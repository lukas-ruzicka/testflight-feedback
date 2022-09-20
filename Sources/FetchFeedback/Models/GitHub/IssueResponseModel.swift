/// An issue response as defined by GitHub
/// [docu](https://docs.github.com/en/rest/issues/issues#create-an-issue)
struct IssueResponseModel: Decodable {

    let id: Int
    let number: Int
    let title: String
}
