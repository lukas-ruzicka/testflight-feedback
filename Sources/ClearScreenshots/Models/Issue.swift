import Foundation
import Utils

struct Issue {

    let timestamp: Date
    let lastUpdate: Date

    init?(from response: IssueResponse) {
        guard let timestamp = response.appStoreConnectCreationDate else { return nil }
        self.timestamp = timestamp
        self.lastUpdate = response.updated_at ?? timestamp
    }
}
