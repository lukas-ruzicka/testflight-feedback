import Foundation

public enum GitHubError: LocalizedError {

    case badCredentials
    case badURL(message: String)
    case unknown(message: String)

    init(from message: String) {
        if message == "Bad credentials" {
            self = .badCredentials
        } else {
            self = .unknown(message: message)
        }
    }

    public var errorDescription: String? {
        switch self {
        case .badCredentials:
            return "Bad credentials"
        case .badURL(let message):
            return "Bad API URL: \(message)"
        case .unknown(let message):
            return message
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .badCredentials:
            return "The GitHub access token seems to be invalid or missing 🙈. Create new one and pass it as command parameter (or set it to `GITHUB_TOKEN` environment variable). If you're using GitHub Actions, dig into the workflows file, because the variable should be provided by the action itself."
        default:
            return nil
        }
    }
}
