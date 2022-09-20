import AppKit
import Sodium
import Utils

final class SecretRepository {

    static func getEncryptedAuthCookies(publicKey: String) throws -> String {
        let sodium = Sodium()
        guard let decodedPublicKey = sodium.utils.base642bin(publicKey),
              let seal = sodium.box.seal(message: try authCookies().bytes, recipientPublicKey: decodedPublicKey) else {
            throw Failure.encryptionFailed
        }
        return Data(seal).base64EncodedString()
    }

    private static func authCookies() throws -> String {
        try Environment.fastlaneSession.value()
    }
}

extension SecretRepository {

    enum Failure: LocalizedError {

        case encryptionFailed

        var errorDescription: String? {
            switch self {
            case .encryptionFailed:
                return "🍪🍪 encryption failed."
            }
        }
    }
}
