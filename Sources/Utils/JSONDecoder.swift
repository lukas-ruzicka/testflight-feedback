import Foundation

public extension JSONDecoder {

    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        return decoder
    }

    static var decoderWithoutMiliseconds: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601WithoutMiliseconds)
        return decoder
    }
}
