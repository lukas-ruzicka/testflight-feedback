import Foundation
import Utils

/// An issue to be create on GitHub
/// [docu](https://docs.github.com/en/rest/issues/issues#create-an-issue)
struct Issue: Encodable {

    let title: String
    let body: String
    let labels: [String]
    let milestone: Int?
}

extension Issue {

    init(from feedback: Feedback, milestoneNumber: Int?, screenshots: [ImageReference]) throws {
        title = DateFormatter.readable.string(from: feedback.attributes.timestamp)
        let originalLink = "https://appstoreconnect.apple.com/apps/\(try Environment.appId.value())/testflight/screenshots/\(feedback.id)?sort=-timestamp"
        let comment = feedback.attributes.comment.unwrap()
        let translationLink = comment.getTranslationLinkIfNotEnglish()
        body = """
        ### User Feedback
        > \(comment.replacingOccurrences(of: "\n", with: "\n> "))
        \(translationLink != nil ? "\n\(translationLink!)\n": "")
        - Email: \(feedback.attributes.emailAddress.unwrap())
        - Submitted on: \(DateFormatter.readable.string(from: feedback.attributes.timestamp))
        - [Original AppStoreConnect Feedback Ticket](\(originalLink))

        ### Screenshots
        \(screenshots.enumerated().reduce("") { $0 + "[![Screenshot_\($1.offset)](\($1.element.thumbnailURL.absoluteString))](\($1.element.url.absoluteString))\n" })

        ### App
        | App Version | App Platform | Uptime |
        |:------:|:------:|:------:|
        | \(feedback.appVersionString) | \(feedback.attributes.appPlatform.unwrap()) | \(feedback.attributes.appUptimeMillis.toHours()) h |

        ### Device
        | Device | Device Family | Device Platform | OS Version | Battery |
        |:------:|:------:|:------:|:------:|:------:|
        | \(feedback.attributes.deviceModelLinked) | \(feedback.attributes.deviceFamily.unwrap()) | \(feedback.attributes.devicePlatform.unwrap()) | \(feedback.attributes.osVersion.unwrap()) | \(feedback.attributes.batteryPercentage ?? 0)% |

        | Carrier | Time Zone | Locale | Architecture |
        |:------:|:------:|:------:|:------:|
        | \(feedback.attributes.carrier.unwrap()) | \(feedback.attributes.timezone.unwrap()) | \(feedback.attributes.locale.unwrap()) | \(feedback.attributes.architecture.unwrap()) |

        | Connection Status | Network Type | Disk Free | Screen Resolution |
        |:------:|:------:|:------:|:------:|
        | \(feedback.attributes.connectionStatus.unwrap()) | \(feedback.attributes.networkType.unwrap()) | \(feedback.attributes.availableDiskBytes.toGB()) /  \(feedback.attributes.totalDiskBytes.toGB()) GB | \(feedback.attributes.screenWidth ?? 0) x \(feedback.attributes.screenHeight ?? 0) |

        <!-- DO NOT MODIFY THE FOLLOWING LINE AND LEAVE IT ALWAYS THE LAST -->
        <!-- \(DateFormatter.iso8601.string(from: feedback.attributes.timestamp)) -->
        """
        var labels: [String] = []
        if let osVersion = feedback.attributes.osVersion {
            labels.append("iOS " + osVersion)
        }
        self.labels = labels
        milestone = milestoneNumber
    }
}

private extension Optional where Wrapped == String {

    func unwrap() -> String {
        self ?? "_Not provided_"
    }

    func toHours() -> String {
        let milis = Double(unwrap()) ?? 0
        return String(format: "%.0f", milis / 1000 / 60 / 60)
    }

    func toGB() -> String {
        let bytes = Double(unwrap()) ?? 0
        return String(format: "%.1f", bytes / 1024 / 1024 / 1024)
    }
}
