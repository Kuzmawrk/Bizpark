import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingComplete: Bool
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            title: "Capture Your Ideas",
            description: "Save your business ideas instantly with titles and descriptions. Never lose a brilliant idea again!",
            imageName: "lightbulb.fill",
            color: .yellow
        ),
        OnboardingPage(
            title: "Track Your Budget",
            description: "Estimate and track potential budgets for your business ideas to keep your plans realistic and organized.",
            imageName: "dollarsign.circle.fill",
            color: .green
        ),
        OnboardingPage(
            title: "Share & Collaborate",
            description: "Share your ideas with partners and collaborators. Edit, update, and manage your ideas with ease.",
            imageName: "square.and.arrow.up.fill",
            color: .blue
        )
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack(spacing: 32) {
                        Spacer()
                        
                        Image(systemName: pages[index].imageName)
                            .font(.system(size: 100))
                            .foregroundColor(pages[index].color)
                            .symbolEffect(.bounce, options: .repeating)
                        
                        Text(pages[index].title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(pages[index].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 32)
                        
                        Spacer()
                        
                        if index == pages.count - 1 {
                            Button {
                                completeOnboarding()
                            } label: {
                                Text("Get Started")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal, 32)
                        } else {
                            Button {
                                withAnimation {
                                    currentPage += 1
                                }
                            } label: {
                                Text("Next")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal, 32)
                        }
                        
                        // Page indicators
                        HStack(spacing: 8) {
                            ForEach(0..<pages.count, id: \.self) { index in
                                Circle()
                                    .fill(currentPage == index ? Color.accentColor : Color.gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                                    .animation(.easeInOut, value: currentPage)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    private func completeOnboarding() {
        withAnimation {
            isOnboardingComplete = true
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let color: Color
}