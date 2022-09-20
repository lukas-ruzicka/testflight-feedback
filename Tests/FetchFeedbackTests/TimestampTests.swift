@testable import FetchFeedback
@testable import Utils
import XCTest

final class TimestampTests: XCTestCase {

    override func setUp() {
        Arguments.setup(appId: "app-id")
    }

    func testTicketTimestampDecoding() throws {
        let timestamp = Date(timeIntervalSinceReferenceDate: 0)
        let feedback = Feedback(
            id: "id",
            attributes: .init(timestamp: timestamp, comment: nil, emailAddress: nil, deviceModel: nil, osVersion: nil, locale: nil, carrier: nil, timezone: nil, architecture: nil, connectionStatus: nil, appUptimeMillis: nil, availableDiskBytes: nil, totalDiskBytes: nil, networkType: nil, batteryPercentage: nil, screenWidth: nil, screenHeight: nil, appPlatform: nil, devicePlatform: nil, deviceFamily: nil), relationships: .init(build: .init(data: .init(id: "id")), screenshots: nil))

        let ticketTimestamp = IssueResponse(body: try Issue(from: feedback, milestoneNumber: nil, screenshots: []).body, pull_request: nil, updated_at: nil).appStoreConnectCreationDate

        XCTAssertEqual(timestamp, ticketTimestamp)
    }
}
