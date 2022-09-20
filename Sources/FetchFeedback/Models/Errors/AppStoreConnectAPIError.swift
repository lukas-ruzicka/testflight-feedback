import Foundation

enum AppStoreConnectAPIError: LocalizedError {

    case notAuthorized(description: String)
    case noFeedback(rawResponse: Data)
    case unknown(description: String)

    var errorDescription: String? {
        switch self {
        case .notAuthorized(let description), .unknown(let description):
            return description
        case .noFeedback:
            return "No feedback was fetched from the App Store Connect 🤔"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .notAuthorized:
            return "You need to refresh the auth 🍪🍪. Run `fastlane spaceauth -u your_appleID_email` and set the output to `FASTLANE_SESSION` environment variable. If you're using GitHub Actions, set the value to a secret with the same name. See the README for more information."
        case .noFeedback(let rawResponse):
            return "Investigate the raw response: \(String(data: rawResponse, encoding: .utf8) ?? "-")"
        default:
            return nil
        }
    }

    init(from error: AppStoreConnectAPIErrorResponseModel.Error) {
        let description = error.title + ".. " + error.detail
        switch error.code {
        case "NOT_AUTHORIZED":
            self = .notAuthorized(description: description)
        default:
            self = .unknown(description: "\(error.code) (\(error.status)): \(description)")
        }
    }

    init(from text: String) {
        if text.starts(with: "Unauthenticated") {
            self = .notAuthorized(description: text)
        } else {
            self = .unknown(description: text)
        }
    }
}
