  import Foundation
  import SwiftUI
  
  class BusinessIdeasViewModel: ObservableObject {
      @Published var ideas: [BusinessIdea] = []
      @Published var showSuccessNotification = false
      @Published var notificationMessage = ""
      private let saveKey = "SavedBusinessIdeas"
      
      init() {
          loadIdeas()
      }
      
      func showNotification(_ message: String) {
          notificationMessage = message
          showSuccessNotification = true
          
          // Hide notification after 4 seconds
          DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
              self.showSuccessNotification = false
          }
      }
      
      func addIdea(title: String, description: String, budget: Double? = nil) {
          let idea = BusinessIdea(title: title, description: description, budget: budget)
          ideas.insert(idea, at: 0)
          saveIdeas()
          showNotification("Idea successfully added!")
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
              showNotification("Idea successfully updated!")
          }
      }
      
      func deleteIdea(at offsets: IndexSet) {
          ideas.remove(atOffsets: offsets)
          saveIdeas()
          showNotification("Idea successfully deleted!")
      }
      
      func deleteIdea(withId id: UUID) {
          ideas.removeAll { $0.id == id }
          saveIdeas()
          showNotification("Idea successfully deleted!")
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