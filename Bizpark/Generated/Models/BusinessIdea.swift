import Foundation

struct BusinessIdea: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var createdAt: Date
    var budget: Double?
    
    init(id: UUID = UUID(), title: String, description: String, budget: Double? = nil, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.budget = budget
        self.createdAt = createdAt
    }
}