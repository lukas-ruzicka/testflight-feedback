import Foundation
import Utils

public func runScript() {
    Task.detached {
        do {
            try await GitHubRepository.uploadAuthCookies()
            exit(EXIT_SUCCESS)
        } catch {
            printFailedJob(error)
            exit(EXIT_FAILURE)
        }
    }
    
    RunLoop.current.run()
}
