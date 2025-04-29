 import SwiftUI
 
 struct AddIdeaView: View {
     @Environment(\.dismiss) private var dismiss
     @Environment(\.colorScheme) private var colorScheme
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
                         .textFieldStyle(CustomTextFieldStyle())
                     
                     VStack(alignment: .leading) {
                         Text("Description")
                             .font(.subheadline)
                             .foregroundColor(.gray)
                             .padding(.bottom, 4)
                         
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
                     }
                     
                     TextField("Estimated Budget (Optional)", text: $budget)
                         .keyboardType(.decimalPad)
                         .textFieldStyle(CustomTextFieldStyle())
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
 
 struct CustomTextFieldStyle: TextFieldStyle {
     @Environment(\.colorScheme) private var colorScheme
     
     func _body(configuration: TextField<Self._Label>) -> some View {
         configuration
             .padding(12)
             .background(
                 RoundedRectangle(cornerRadius: 8)
                     .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color(.systemBackground))
             )
             .overlay(
                 RoundedRectangle(cornerRadius: 8)
                     .stroke(Color.gray.opacity(0.2), lineWidth: 1)
             )
     }
 }