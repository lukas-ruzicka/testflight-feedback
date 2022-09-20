import Foundation

public extension URLRequest {

    init(url: URL, method: HTTPMethod) throws {
        self.init(url: url)
        httpMethod = method.rawValue
    }

    init<T: Encodable>(url: URL, method: HTTPMethod, body: T, encoder: JSONEncoder = JSONEncoder()) throws {
        self.init(url: url)
        httpMethod = method.rawValue
        httpBody = try encoder.encode(body)
    }
}

public enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
