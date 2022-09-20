import Foundation
import Utils

final class FeedbackRepository {

    struct AppVersion {

        let releaseVersion: String
        let buildVersion: String
    }

    static var appVersions: [String: AppVersion] = [:]
    static var screenshotURLs: [String: ImageReference] = [:]

    static func getFeedbacks(attempt: Int = 0) async throws -> [Feedback] {
        let data = try await fetchFeedbacks()
        let decoded = try decodeFeedbacks(data)
        if decoded.data.isEmpty {
            let noFeedbackError = AppStoreConnectAPIError.noFeedback(rawResponse: data)
            guard attempt < 3 else { throw noFeedbackError }
            print("\(noFeedbackError.localizedDescription). Trying again..", color: .yellow)
            return try await getFeedbacks(attempt: attempt + 1)
        }
        try await saveMetadata(decoded)
        return decoded.data
    }
}

private extension FeedbackRepository {

    static func fetchFeedbacks() async throws -> Data {
        var request = URLRequest(url: try feedbacksURL())
        try request.setupFastlaneAuthorization()

        print("Fetching feedback with request: \(request.description)", color: .cyan)
        return try await URLSession.shared.data(for: request).0
    }

    static func decodeFeedbacks(_ data: Data) throws -> FeedbackResponseModel {
        do {
            return try JSONDecoder.decoder.decode(FeedbackResponseModel.self, from: data)
        } catch {
            if let decodedError = try? JSONDecoder.decoder.decode(AppStoreConnectAPIErrorResponseModel.self, from: data).errors.first {
                throw AppStoreConnectAPIError(from: decodedError)
            }
            if let textResponse = String(data: data, encoding: .utf8), !textResponse.isEmpty {
                throw AppStoreConnectAPIError(from: textResponse)
            }
            throw error
        }
    }

    static func saveMetadata(_ response: FeedbackResponseModel) async throws {
        try await saveVersions(response)
        saveScreenshots(response)
    }

    static func saveVersions(_ response: FeedbackResponseModel) async throws {
        let versions = response.included?.filter { $0.type == "builds" } ?? []
        for version in versions {
            guard let buildVersion = version.attributes.version else { return }
            let releaseVersion = try? await fetchReleaseVersion(for: version.id, buildVersion: buildVersion)
            appVersions[version.id] = .init(releaseVersion: releaseVersion ?? "Unknown", buildVersion: buildVersion)
        }
    }

    static func fetchReleaseVersion(for id: String, buildVersion: String, attempt: Int = 0) async throws -> String {
        let url = try baseIrisURL()
            .appendingPathComponent("builds")
            .appendingPathComponent(id)
            .appendingPathComponent("preReleaseVersion")
        var request = URLRequest(url: url)
        try request.setupFastlaneAuthorization()

        do {
            let data = try await URLSession.shared.data(for: request).0
            return try JSONDecoder.decoder.decode(ReleaseVersionResponseModel.self, from: data).data.attributes.version
        } catch {
            if attempt < 3 {
                return try await fetchReleaseVersion(for: id, buildVersion: buildVersion, attempt: attempt + 1)
            }
            print([
                .init(text: "Failed to fetch release version for \(buildVersion): ", color: .red, bold: true),
                .init(text: error.localizedDescription, color: .red)
            ])
            throw error
        }
    }

    static func saveScreenshots(_ response: FeedbackResponseModel) {
        let screenshots = response.included?.filter { $0.type == "betaScreenshots" }
        screenshots?.forEach {
            guard let images = $0.attributes.imageAssets,
                  images.count >= 2,
                  let large = images.max(by: { $0.height < $1.height })?.url,
                  let largeURL = URL(string: large),
                  let smallURL = URL(string: images.sorted(by: { $0.height < $1.height })[1].url) else { return }
            screenshotURLs[$0.id] = .init(thumbnailURL: smallURL, url: largeURL)
        }
    }
}

private extension FeedbackRepository {

    static func feedbacksURL() throws -> URL {
        let feedbacksURL = try baseIrisURL().appendingPathComponent("betaFeedbacks")
        var urlComponents = URLComponents(url: feedbacksURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            .init(name: "filter[build.app]", value: try Environment.appId.value()),
            .init(name: "filter[buildBundle.bundleType]", value: "APP"),
            .init(name: "filter[devicePlatform]", value: "IOS"),
            .init(name: "exists[crash]", value: "false"),
            .init(name: "include", value: "build,screenshots"),
            .init(name: "fields[builds]", value: "version"),
            .init(name: "fields[betaScreenshots]", value: "imageAssets"),
            .init(name: "limit", value: "60"),
            .init(name: "sort", value: "-timestamp"),
        ]
        return urlComponents.url!
    }

    static func baseIrisURL() throws -> URL {
        URL(string: "https://appstoreconnect.apple.com/iris/provider/\(try Environment.issuerId.value())/v1")!
    }
}

private extension URLRequest {

    mutating func setupFastlaneAuthorization() throws {
        allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: try authCookies())
    }

    func authCookies() throws -> [HTTPCookie] {
        try Environment.fastlaneSession.value().parseCookies()
    }
}
