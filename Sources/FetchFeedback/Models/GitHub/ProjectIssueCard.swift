/// Required to create add an issue to a board
/// [docu](https://developer.github.com/v3/projects/cards/#create-a-project-card)
struct ProjectIssueCard {

    let issueId: Int
}

extension ProjectIssueCard: Encodable {

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(Optional<String>.none, forKey: .note)
        try container.encode("Issue", forKey: .content_type)
        try container.encode(issueId, forKey: .content_id)
    }

    private enum CodingKeys: String, CodingKey {
        case note
        case content_type
        case content_id
    }
}
