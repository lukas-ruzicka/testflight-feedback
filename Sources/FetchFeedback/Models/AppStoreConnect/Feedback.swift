import Foundation

struct Feedback: Decodable {

    let id: String
    let attributes: Attributes
    let relationships: Relationships

    var appVersion: FeedbackRepository.AppVersion {
        FeedbackRepository.appVersions[relationships.build.data.id] ?? .init(releaseVersion: "Unknown", buildVersion: "Unknown Build")
    }
    var appVersionString: String {
        "\(appVersion.releaseVersion) (\(appVersion.buildVersion))"
    }
    var screenshotURLs: [ImageReference] {
        relationships.screenshots?.data.compactMap { FeedbackRepository.screenshotURLs[$0.id] } ?? []
    }

    struct Attributes: Decodable {

        let timestamp: Date
        let comment: String?
        let emailAddress: String?
        let deviceModel: String?
        let osVersion: String?
        let locale: String?
        let carrier: String?
        let timezone: String?
        let architecture: String?
        let connectionStatus: String?
        let appUptimeMillis: String?
        let availableDiskBytes: String?
        let totalDiskBytes: String?
        let networkType: String?
        let batteryPercentage: Int?
        let screenWidth: Int?
        let screenHeight: Int?
        let appPlatform: String?
        let devicePlatform: String?
        let deviceFamily: String?
    }

    struct Relationships: Decodable {

        let build: Build
        let screenshots: Screenshots?

        struct Build: Decodable {

            let data: Data

            struct Data: Decodable {

                let id: String
            }
        }

        struct Screenshots: Decodable {

            let data: [Data]

            struct Data: Decodable {

                let id: String
            }
        }
    }
}

extension Feedback.Attributes {

    var deviceModelLinked: String {
        guard let deviceModel = deviceModel,
              let deviceModelURL = deviceModelURL else {
            return "_Not provided_"
        }

        let deviceName = DeviceName(rawValue: deviceModel)?.name ?? deviceModel
        return "[\(deviceName)](\(deviceModelURL))"
    }

    private var commaSeparatedModel: String? {
        deviceModel?.replacingOccurrences(of: "_", with: ",")
    }

    var deviceModelURL: String? {
        commaSeparatedModel.map { "https://everymac.com/ultimate-mac-lookup/?search_keywords=\($0)" }
    }
}
