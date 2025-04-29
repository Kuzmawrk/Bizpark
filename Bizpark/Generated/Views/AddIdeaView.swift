import SwiftUI

struct AddIdeaView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BusinessIdeasViewModel
    
    @State private var title = ""
    @State private var description = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, description
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Idea Title", text: $title)
                        .focused($focusedField, equals: .title)
                        .font(.headline)
                        .submitLabel(.next)
                    
                    TextEditor(text: $description)
                        .focused($focusedField, equals: .description)
                        .frame(height: 150)
                        .font(.body)
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
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(focusedField == .title ? "Next" : "Done") {
                        if focusedField == .title {
                            focusedField = .description
                        } else {
                            focusedField = nil
                        }
                    }
                }
            }
        }
    }
    
    private func saveIdea() {
        viewModel.addIdea(title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                         description: description.trimmingCharacters(in: .whitespacesAndNewlines))
        dismiss()
    }
}