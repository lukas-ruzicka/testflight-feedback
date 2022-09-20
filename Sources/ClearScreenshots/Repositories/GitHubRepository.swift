import Foundation
import Utils

final class GitHubRepository {

    // MARK: - Issues

    static func getClosedIssues(page: Int = 1) async throws -> [Issue] {
        try await GitHubHelper.fetchLatestIssues(count: 100, // Max allowed count
                                                 page: page,
                                                 issueState: .closed)
            .compactMap { .init(from: $0) }
    }

    // MARK: - Screenshots

    static func listUploadedScreenshots() async throws -> [RepositoryContent] {
        let request = URLRequest(url: try GitHubHelper.screenshotsFolderURL())
        let response: [RepositoryContent] = try await GitHubNetworking.perform(dataRequest: request)
        return response
    }

    static func deleteFile(name: String, sha: String) async throws {
        let request = try URLRequest(url: try GitHubHelper.screenshotsFolderURL().appendingPathComponent(name),
                                     method: .delete,
                                     body: DeleteContentBody(message: "Removing screenshot \(name)", sha: sha))
        try await GitHubNetworking.perform(request: request)
        print("Successfully deleted \(name)", color: .green)
    }
}
