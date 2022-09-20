import Foundation

public final class GitHubHelper {

    // NOTE: - The endpoint considers Pull Requests to be Issues too, so we need to fetch more of them by default to ensure that one is the latest created Issue
    public static func fetchLatestIssues(count: Int = 30, page: Int = 1, issueState: GitHubIssueState = .all) async throws -> [IssueResponse] {
        let request = URLRequest(url: try fetchLatestIssuesURL(count: count, page: page, issueState: issueState))
        print("Fetching tickets with request: \(request.description)", color: .cyan)
        let response: [IssueResponse] = try await GitHubNetworking.perform(dataRequest: request, decoder: .decoderWithoutMiliseconds)
        return response
            .filter(\.isIssue)
    }
}

public extension GitHubHelper {

    static var apiURL: URL {
        URL(string: "https://api.github.com/")!
    }

    static func repositoryURL() throws -> URL {
        var url = apiURL.appendingPathComponent("repos")
        let path = try Environment.repositoryPath.value()
        url.appendPathComponent(path)
        return url
    }

    static func issuesURL() throws -> URL {
        try repositoryURL()
            .appendingPathComponent("issues")
    }

    /// [docu](https://docs.github.com/en/rest/issues/issues#list-repository-issues)
    static func fetchLatestIssuesURL(count: Int = 10, page: Int = 1, issueState: GitHubIssueState = .all) throws -> URL {
        var urlComponents = URLComponents(url: try issuesURL(), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            .init(name: "state", value: "\(issueState.rawValue)"),
            .init(name: "sort", value: "created"),
            .init(name: "direction", value: "desc"),
            .init(name: "per_page", value: "\(count > 100 ? 100 : count)"),
            .init(name: "page", value: "\(page)")
        ]
        guard let url = urlComponents.url else { throw GitHubError.badURL(message: urlComponents.description) }
        return url
    }

    static func screenshotsFolderURL() throws -> URL {
        try repositoryURL()
            .appendingPathComponent("contents")
            .appendingPathComponent("screenshots")
    }
}
