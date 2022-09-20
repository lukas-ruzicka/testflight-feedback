import Foundation
import Utils

final class GitHubRepository {

    static func uploadAuthCookies() async throws {
        let publicKey = try await getRepositoryPublicKey()
        let encryptedAuthCookies = try SecretRepository.getEncryptedAuthCookies(publicKey: publicKey.key)
        try await saveAuthCookiesToRepository(.init(encrypted_value: encryptedAuthCookies, key_id: publicKey.key_id))
        print("Successfully uploaded the authorization cookies to your repository 🙌🏼", color: .green)
    }

    private static func getRepositoryPublicKey() async throws -> RepositoryPublicKey {
        let request = try URLRequest(url: try publicKeyURL(), method: .get)
        return try await GitHubNetworking.perform(dataRequest: request)
    }

    private static func saveAuthCookiesToRepository(_ body: UploadSecretBody) async throws {
        let request = try URLRequest(url: try secretURL(secretName: "FASTLANE_SESSION"), method: .put, body: body)
        try await GitHubNetworking.perform(request: request)
    }
}

private extension GitHubRepository {

    static func publicKeyURL() throws -> URL {
        try secretsURL().appendingPathComponent("public-key")
    }

    static func secretURL(secretName: String) throws -> URL {
        try secretsURL().appendingPathComponent(secretName)
    }

    static func secretsURL() throws -> URL {
        try GitHubHelper.repositoryURL().appendingPathComponent("actions/secrets")
    }
}
