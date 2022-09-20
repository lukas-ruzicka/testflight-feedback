import AppKit
import Foundation

/// Environment variables
public enum Environment: String {

    case fastlaneSession = "FASTLANE_SESSION"
    case githubToken = "GITHUB_TOKEN"
    case repositoryPath = "FEEDBACK_REPOSITORY_PATH"
    case appId = "FEEDBACK_APP_ID"
    case issuerId = "FEEDBACK_ISSUER_ID"
    case backlogColumnId = "FEEDBACK_BACKLOG_COLUMN_ID"

    public func value() throws -> String {
        if let passedValue = passedValue, !passedValue.isEmpty {
            return passedValue
        }
        let value = ProcessInfo.processInfo.environment[rawValue]
        guard let value = value, !value.isEmpty else {
            if self == .fastlaneSession {
                throw Failure.missingFastlaneSession
            }
            print("\(rawValue) is not set..", color: .yellow)
            throw Failure.missingValue(key: self)
        }
        return value
    }

    var passedValue: String? {
        switch self {
        case .fastlaneSession:
            if let clipboardOutput = NSPasteboard.general.string(forType: .string),
                !clipboardOutput.parseCookies().isEmpty {
                return clipboardOutput
            }
            return nil
        case .githubToken:
            return Arguments.shared?.githubToken
        case .repositoryPath:
            return Arguments.shared?.repositoryPath
        case .appId:
            return Arguments.shared?.appId
        case .issuerId:
            return Arguments.shared?.issuerId
        case .backlogColumnId:
            return Arguments.shared?.backlogColumnId
        }
    }
}

extension Environment {

    enum Failure: LocalizedError {

        case missingValue(key: Environment)
        case missingFastlaneSession

        var errorDescription: String? {
            switch self {
            case .missingValue(let key):
                return "Missing value for \(key.rawValue)"
            case .missingFastlaneSession:
                return "The authorization cookies are missing."
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .missingFastlaneSession:
                return "You need to provide the auth 🍪🍪. Run `fastlane spaceauth -u your_appleID_email` and choose to copy the output to clipboard (or set the output to `FASTLANE_SESSION` environment variable)."
            default:
                return nil
            }
        }
    }
}
