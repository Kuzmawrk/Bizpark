import Foundation
import SwiftUI

class BusinessIdeasViewModel: ObservableObject {
    @Published var ideas: [BusinessIdea] = []
    @Published var showSuccessNotification = false
    private let saveKey = "SavedBusinessIdeas"
    
    init() {
        loadIdeas()
    }
    
    func addIdea(title: String, description: String, budget: Double? = nil) {
        let idea = BusinessIdea(title: title, description: description, budget: budget)
        ideas.insert(idea, at: 0)
        saveIdeas()
        showSuccessNotification = true
        
        // Hide notification after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showSuccessNotification = false
        }
    }
    
    func updateIdea(id: UUID, title: String, description: String, budget: Double?) {
        if let index = ideas.firstIndex(where: { $0.id == id }) {
            ideas[index] = BusinessIdea(
                id: id,
                title: title,
                description: description,
                budget: budget,
                createdAt: ideas[index].createdAt
            )
            saveIdeas()
        }
    }
    
    func deleteIdea(at offsets: IndexSet) {
        ideas.remove(atOffsets: offsets)
        saveIdeas()
    }
    
    func deleteIdea(withId id: UUID) {
        ideas.removeAll { $0.id == id }
        saveIdeas()
    }
    
    private func saveIdeas() {
        if let encoded = try? JSONEncoder().encode(ideas) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadIdeas() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([BusinessIdea].self, from: data) {
            ideas = decoded
        }
    }
}