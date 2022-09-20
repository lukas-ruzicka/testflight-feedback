import ArgumentParser
import Authorize
import ClearScreenshots
import FetchFeedback
import Utils

struct TestflightFeedback: ParsableCommand {

    static var configuration = CommandConfiguration(
        abstract: "Tool for managing feedback from TestFlight.",
        subcommands: [Fetch.self, Auth.self, Clear.self]
    )
}

// MARK: - Subcommands
extension TestflightFeedback {

    struct Fetch: ParsableCommand {

        static var configuration = CommandConfiguration(abstract: "Fetches user feedback from TestFlight and creates GitHub Issues out of it.")

        @OptionGroup
        var commonOptions: CommonOptions

        @Option(name: .shortAndLong, help: "App Store App ID. Can be set using \"FEEDBACK_APP_ID\" environment variable.")
        var appId: String?

        @Option(name: .shortAndLong, help: "Issuer ID of your Apple Developer account. Can be set using \"FEEDBACK_ISSUER_ID\" environment variable.")
        var issuerId: String?

        @Option(name: .shortAndLong, help: "GitHub column ID to which the newly created ticket should be added. Can be set using \"FEEDBACK_BACKLOG_COLUMN_ID\" environment variable.")
        var backlogColumnId: String?

        func run() throws {
            Arguments.setup(githubToken: commonOptions.githubToken,
                            repositoryPath: commonOptions.repositoryPath,
                            appId: appId,
                            issuerId: issuerId,
                            backlogColumnId: backlogColumnId)
            FetchFeedback.runScript()
        }
    }

    struct Auth: ParsableCommand {

        static var configuration = CommandConfiguration(abstract: "Uploads the authorization cookies to the GitHub repository. You need to create the cookies before using `fastlane spaceauth -u your_apple_id` and select to copy it to your clipboard once it's finished (or you can set it as `FASTLANE_SESSION` environment variable).")

        @OptionGroup
        var commonOptions: CommonOptions

        func run() throws {
            Arguments.setup(githubToken: commonOptions.githubToken,
                            repositoryPath: commonOptions.repositoryPath)
            Authorize.runScript()
        }
    }

    struct Clear: ParsableCommand {

        static var configuration = CommandConfiguration(abstract: "Clears old screenshots from the GitHub repository.")

        @OptionGroup
        var commonOptions: CommonOptions

        func run() throws {
            Arguments.setup(githubToken: commonOptions.githubToken,
                            repositoryPath: commonOptions.repositoryPath)
            ClearScreenshots.runScript()
        }
    }
}

// MARK: - Arguments
extension TestflightFeedback {

    struct CommonOptions: ParsableArguments {

        @Option(name: .shortAndLong, help: "GitHub personal access token with the `repo` scope. Can be set using \"GITHUB_TOKEN\" environment variable.")
        var githubToken: String?

        @Option(name: .shortAndLong, help: "Path to the GitHub repository. Can be set using \"FEEDBACK_REPOSITORY_PATH\" environment variable.")
        var repositoryPath: String?
    }
}

TestflightFeedback.main()
