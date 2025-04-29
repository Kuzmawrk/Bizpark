import SwiftUI

struct IdeaDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel: BusinessIdeasViewModel
    let idea: BusinessIdea
    
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(idea.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(idea.createdAt.formatted(date: .long, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.accentColor.opacity(0.1))
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                    
                    Text(idea.description)
                        .lineSpacing(4)
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .primary)
                }
                
                if let budget = idea.budget {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Estimated Budget")
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        
                        Text(String(format: "$%.2f", budget))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colorScheme == .dark ? Color.green.opacity(0.2) : Color.green.opacity(0.1))
                            )
                    }
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Label("Edit", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    
                    Button(action: {
                        shareIdea()
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                }
                
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Label("Delete Idea", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditSheet) {
            EditIdeaView(viewModel: viewModel, idea: idea)
        }
        .alert("Delete Idea", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                deleteIdea()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this idea? This action cannot be undone.")
        }
    }
    
    private func shareIdea() {
        let shareText = """
        Business Idea: \(idea.title)
        
        Description:
        \(idea.description)
        
        \(idea.budget.map { String(format: "Estimated Budget: $%.2f", $0) } ?? "")
        
        Shared from Bizpark
        """
        
        let av = UIActivityViewController(
            activityItems: [shareText],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            av.popoverPresentationController?.sourceView = rootVC.view
            rootVC.present(av, animated: true)
        }
    }
    
    private func deleteIdea() {
        viewModel.deleteIdea(withId: idea.id)
        dismiss()
    }
}