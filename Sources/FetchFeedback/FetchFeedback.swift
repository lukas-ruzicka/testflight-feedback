import Foundation
import Utils

public func runScript() {
    Task.detached {
        do {
            let feedbacks = try await FeedbackRepository.getFeedbacks()
            let lastTicketTimestamp = try await GitHubRepository.getLastIssueTimestamp()
            let newFeedbacks = feedbacks.newer(than: lastTicketTimestamp)
            print("Successfully fetched \(newFeedbacks.count) new feedback \(newFeedbacks.count > 0 ? "🤩" : "😭")", color: .green, bold: true)
            if !newFeedbacks.isEmpty {
                let githubRepo = try await GitHubRepository()
                
                for feedback in newFeedbacks {
                    try await githubRepo.setupIssue(feedback: feedback)
                }
            }
            exit(EXIT_SUCCESS)
        } catch {
            printFailedJob(error)
            exit(EXIT_FAILURE)
        }
    }

    RunLoop.current.run()
}
