import Foundation

public enum GitHubNetworking {

    public static func perform(request: URLRequest) async throws {
        var request = request
        try request.setGitHubAuthorizationHeader()
        let (data, _) = try await URLSession.shared.data(for: request)
        try data.checkForError()
    }

    public static func perform<T: Decodable>(dataRequest: URLRequest, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        var dataRequest = dataRequest
        try dataRequest.setGitHubAuthorizationHeader()
        let (data, _) = try await URLSession.shared.data(for: dataRequest)
        try data.checkForError()

        return try decoder.decode(T.self, from: data)
    }
}

private extension URLRequest {

    /// [docu](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#authentication)
    mutating func setGitHubAuthorizationHeader() throws {
        do {
            let githubToken = try Environment.githubToken.value()
            setValue("token \(githubToken)", forHTTPHeaderField: "Authorization")
        } catch {
            throw GitHubError.badCredentials
        }
    }
}

private extension Data {

    func checkForError() throws {
        if let decodedError = try? JSONDecoder.decoderWithoutMiliseconds.decode(GitHubErrorResponseModel.self, from: self) {
            throw GitHubError(from: decodedError.message)
        }
    }
}
