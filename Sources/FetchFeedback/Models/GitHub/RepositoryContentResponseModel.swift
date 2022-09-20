import Foundation

/// Response from creating file in repository
/// [docu](https://docs.github.com/en/rest/repos/contents#create-or-update-file-contents)
struct RepositoryContentResponseModel: Decodable {

    let content: Content

    struct Content: Decodable {

        let html_url: URL
    }
}
