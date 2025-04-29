import SwiftUI

struct EditIdeaView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BusinessIdeasViewModel
    let idea: BusinessIdea
    
    @State private var title: String
    @State private var description: String
    @State private var budget: String
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, description, budget
    }
    
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
                        .focused($focusedField, equals: .title)
                        .font(.headline)
                        .submitLabel(.next)
                    
                    TextEditor(text: $description)
                        .focused($focusedField, equals: .description)
                        .frame(height: 150)
                    
                    TextField("Budget (Optional)", text: $budget)
                        .focused($focusedField, equals: .budget)
                        .keyboardType(.decimalPad)
                        .submitLabel(.done)
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
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(focusedField == .budget ? "Done" : "Next") {
                        switch focusedField {
                        case .title:
                            focusedField = .description
                        case .description:
                            focusedField = .budget
                        default:
                            focusedField = nil
                        }
                    }
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