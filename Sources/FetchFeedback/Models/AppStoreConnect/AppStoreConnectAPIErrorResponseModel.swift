struct AppStoreConnectAPIErrorResponseModel: Decodable {

    let errors: [Error]

    struct Error: Decodable {

        let status: String
        let code: String
        let title: String
        let detail: String
    }
}
