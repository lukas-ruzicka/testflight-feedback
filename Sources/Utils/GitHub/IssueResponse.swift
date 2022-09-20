import Foundation

/// [docu](https://docs.github.com/en/rest/issues/issues#list-repository-issues)
/// > You can identify pull requests by the pull_request key
public struct IssueResponse: Decodable {

    /// The body (i.e. description) of the issue
    let body: String?
    let pull_request: PullRequest?
    public let updated_at: Date?

    struct PullRequest: Decodable {
        
        let url: URL
    }
}

public extension IssueResponse {

    /// Creation date of the original ticket on AppStoreConnect
    var appStoreConnectCreationDate: Date? {
        creationDate.flatMap(DateFormatter.iso8601.date(from:))
    }

    /// The creation date is stored within the description (body) of each issue
    /// - seealso: `Issue.swift`
    var creationDate: String? {
        body?.split(whereSeparator: \.isNewline).last?
            .replacingOccurrences(of: "<!-- ", with: "")
            .replacingOccurrences(of: " -->", with: "")
            .trimmingCharacters(in: .whitespaces)
    }

    var isIssue: Bool {
        type == .issue
    }

    var type: IssueType {
        pull_request == nil ? .issue : .pullRequest
    }

    enum IssueType {

        case issue
        case pullRequest
    }
}
