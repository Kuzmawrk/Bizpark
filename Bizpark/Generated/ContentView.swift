 import SwiftUI
 
 struct ContentView: View {
     @StateObject private var viewModel = BusinessIdeasViewModel()
     @State private var showingAddIdea = false
     @AppStorage("isDarkMode") private var isDarkMode = false
     @State private var isAnimating = false
     @AppStorage("isOnboardingComplete") private var isOnboardingComplete = false
     
     var body: some View {
         Group {
             if !isOnboardingComplete {
                 OnboardingView(isOnboardingComplete: $isOnboardingComplete)
             } else {
                 TabView {
                     NotesView(viewModel: viewModel)
                         .tabItem {
                             Label("Notes", systemImage: "note.text")
                         }
                     
                     SettingsView()
                         .tabItem {
                             Label("Settings", systemImage: "gearshape.fill")
                         }
                 }
                 .preferredColorScheme(isDarkMode ? .dark : .light)
             }
         }
     }
 }
 
 struct NotesView: View {
     @ObservedObject var viewModel: BusinessIdeasViewModel
     @State private var showingAddIdea = false
     @State private var isAnimating = false
     
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
                                 .scaleEffect(isAnimating ? 1.1 : 1.0)
                                 .animation(
                                     Animation.easeInOut(duration: 1.0)
                                         .repeatForever(autoreverses: true),
                                     value: isAnimating
                                 )
                                 .onAppear {
                                     isAnimating = true
                                 }
                             
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
                                 NavigationLink(destination: IdeaDetailView(viewModel: viewModel, idea: idea)) {
                                     IdeaCardView(idea: idea)
                                 }
                             }
                         }
                         .padding(.vertical)
                     }
                 }
                 
                 if viewModel.showSuccessNotification {
                     VStack {
                         Spacer()
                         HStack {
                             Image(systemName: "checkmark.circle.fill")
                                 .foregroundColor(.green)
                             Text("Idea successfully added!")
                                 .foregroundColor(.white)
                         }
                         .padding()
                         .background(Color.black.opacity(0.8))
                         .cornerRadius(25)
                         .padding(.bottom, 20)
                     }
                     .transition(.move(edge: .bottom))
                     .animation(.spring(), value: viewModel.showSuccessNotification)
                 }
             }
             .navigationTitle("Notes")
             .toolbar {
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
     }
 }