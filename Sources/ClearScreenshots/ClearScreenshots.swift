import Foundation
import Utils

public func runScript() {
    Task.detached {
        do {
            let uploadedScreenshots = try await GitHubRepository.listUploadedScreenshots()
            let screenshotsToDelete = try await uploadedScreenshots.filterScreenshotsToDelete()
            for screenshot in screenshotsToDelete {
                try await GitHubRepository.deleteFile(name: screenshot.name, sha: screenshot.sha)
            }
            exit(EXIT_SUCCESS)
        } catch {
            printFailedJob(error)
            exit(EXIT_FAILURE)
        }
    }
    
    RunLoop.current.run()
}
