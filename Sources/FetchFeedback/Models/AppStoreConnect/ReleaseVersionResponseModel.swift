struct ReleaseVersionResponseModel: Decodable {

    let data: Data

    struct Data: Decodable {

        let attributes: Attributes

        struct Attributes: Decodable {

            let version: String
        }
    }
}
