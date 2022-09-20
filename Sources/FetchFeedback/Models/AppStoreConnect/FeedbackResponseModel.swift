import Foundation

struct FeedbackResponseModel: Decodable {

    let data: [Feedback]
    let included: [Included]?

    struct Included: Decodable {

        let type: String
        let id: String
        let attributes: Attributes

        struct Attributes: Decodable {

            let version: String?
            let imageAssets: [ImageAssets]?

            struct ImageAssets: Decodable {

                let url: String
                let width: Double
                let height: Double
            }
        }
    }
}
