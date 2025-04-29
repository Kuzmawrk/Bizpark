import SwiftUI

struct EditIdeaView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel: BusinessIdeasViewModel
    let idea: BusinessIdea
    
    @State private var title: String
    @State private var description: String
    @State private var budget: String
    
    init(viewModel: BusinessIdeasViewModel, idea: BusinessIdea) {
        self.viewModel = viewModel
        self.idea = idea
        _title = State(initialValue: idea.title)
        _description = State(initialValue: idea.description)
        _budget = State(initialValue: idea.budget.map { String(format: "%.2f", $0) } ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .font(.headline)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    TextEditor(text: $description)
                        .frame(height: 150)
                        .font(.body)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color(.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    
                    TextField("Budget (Optional)", text: $budget)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(CustomTextFieldStyle())
                }
            }
            .navigationTitle("Edit Idea")
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
        viewModel.updateIdea(
            id: idea.id,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            budget: budgetValue
        )
        dismiss()
    }
}