public struct Arguments {

    let githubToken: String?
    let repositoryPath: String?
    let appId: String?
    let issuerId: String?
    let backlogColumnId: String?

    static var shared: Arguments?

    public static func setup(githubToken: String? = nil,
                             repositoryPath: String? = nil,
                             appId: String? = nil,
                             issuerId: String? = nil,
                             backlogColumnId: String? = nil) {
        shared = .init(githubToken: githubToken,
                       repositoryPath: repositoryPath,
                       appId: appId,
                       issuerId: issuerId,
                       backlogColumnId: backlogColumnId)
    }
}
