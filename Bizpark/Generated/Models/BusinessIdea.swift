import Foundation

struct BusinessIdea: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, description: String, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
    }
}