import Foundation
import SwiftUI

class BusinessIdeasViewModel: ObservableObject {
    @Published var ideas: [BusinessIdea] = []
    private let saveKey = "SavedBusinessIdeas"
    
    init() {
        loadIdeas()
    }
    
    func addIdea(title: String, description: String) {
        let idea = BusinessIdea(title: title, description: description)
        ideas.insert(idea, at: 0)
        saveIdeas()
    }
    
    func deleteIdea(at offsets: IndexSet) {
        ideas.remove(atOffsets: offsets)
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