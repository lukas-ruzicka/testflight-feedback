/// Body for request to create file in repository
/// [docu](https://docs.github.com/en/rest/repos/contents#create-or-update-file-contents)
struct RepositoryContentBody: Encodable {

    let message: String
    let content: String
}
