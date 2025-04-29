import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BusinessIdeasViewModel()
    @State private var showingAddIdea = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    if viewModel.ideas.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "lightbulb")
                                .font(.system(size: 60))
                                .foregroundColor(.yellow)
                            
                            Text("No Business Ideas Yet")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Tap the + button to add your first business idea!")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                    } else {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.ideas) { idea in
                                IdeaCardView(idea: idea)
                                    .transition(.opacity)
                            }
                            .onDelete(perform: viewModel.deleteIdea)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Bizpark")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddIdea = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddIdea) {
                AddIdeaView(viewModel: viewModel)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}