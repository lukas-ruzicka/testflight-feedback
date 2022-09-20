import Foundation

extension Array where Element == RepositoryContent {

    func filterScreenshotsToDelete(issuesPage: Int = 1) async throws -> [RepositoryContent] {
        let closedIssues = try await GitHubRepository.getClosedIssues(page: issuesPage)
        if closedIssues.isEmpty {
            return []
        }
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: .init())!
        let oldClosedTimestamps = closedIssues
            .filter { $0.lastUpdate < monthAgo }
            .map(\.timestamp)
        if oldClosedTimestamps.isEmpty {
            return try await filterScreenshotsToDelete(issuesPage: issuesPage + 1)
        }

        var oldScreenshots: [RepositoryContent] = []
        for screenshot in self {
            guard let dateString = screenshot.name.split(separator: "_").first,
                  let date = DateFormatter.iso8601.date(from: String(dateString)) else { continue }
            if oldClosedTimestamps.contains(date) {
                oldScreenshots.append(screenshot)
            }
        }
        if !oldScreenshots.isEmpty {
            oldScreenshots += try await filterScreenshotsToDelete(issuesPage: issuesPage + 1)
        }
        return oldScreenshots
    }
}
