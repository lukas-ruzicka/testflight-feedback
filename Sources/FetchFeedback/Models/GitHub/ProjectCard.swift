/// Card of a project column
/// [docu](https://docs.github.com/en/rest/projects/cards#create-a-project-card)
struct ProjectCard: Decodable {
    
    let id: Int
    let title: String?
}
