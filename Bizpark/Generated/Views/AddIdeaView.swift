import SwiftUI

struct AddIdeaView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BusinessIdeasViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var budget = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Idea Title", text: $title)
                        .font(.headline)
                    
                    TextEditor(text: $description)
                        .frame(height: 150)
                        .font(.body)
                    
                    TextField("Estimated Budget (Optional)", text: $budget)
                        .keyboardType(.decimalPad)
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("New Business Idea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveIdea()
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
            }
        }
    }
    
    private func saveIdea() {
        let budgetValue = Double(budget.replacingOccurrences(of: ",", with: "."))
        viewModel.addIdea(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            budget: budgetValue
        )
        dismiss()
    }
}