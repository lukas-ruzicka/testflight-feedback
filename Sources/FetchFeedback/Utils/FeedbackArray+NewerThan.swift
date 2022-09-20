import Foundation

extension Array where Element == Feedback {

    func newer(than date: Date?) -> [Feedback] {
        filter {
            $0.attributes.timestamp.timeIntervalSinceReferenceDate.rounded(.down) > (date ?? .init(timeIntervalSince1970: 0)).timeIntervalSinceReferenceDate.rounded(.down)
        }
    }
}
