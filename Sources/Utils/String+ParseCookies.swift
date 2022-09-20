import Foundation

public extension String {

    func parseCookies() -> [HTTPCookie] {
        let lines = split(separator: "\\").map { $0.replacingOccurrences(of: "n  ", with: "") }
        var cookies: [HTTPCookie?] = []
        var cookieProperties: [HTTPCookiePropertyKey : Any] = [:]
        lines.forEach { line in
            if line.starts(with: "name: ") {
                if !cookieProperties.isEmpty {
                    cookies.append(.init(properties: cookieProperties))
                    cookieProperties = [:]
                }
                cookieProperties[.name] = line.replacingOccurrences(of: "name: ", with: "")
            }
            if line.starts(with: "value: ") {
                cookieProperties[.value] = line.replacingOccurrences(of: "value: ", with: "")
            }
            if line.starts(with: "domain: ") {
                cookieProperties[.domain] = line.replacingOccurrences(of: "domain: ", with: "")
            }
            if line.starts(with: "path: ") {
                cookieProperties[.path] = line.replacingOccurrences(of: "path: ", with: "")
            }
        }
        cookies.append(.init(properties: cookieProperties))
        return cookies.compactMap { $0 }
    }
}
