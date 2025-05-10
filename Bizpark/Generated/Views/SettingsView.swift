import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.openURL) private var openURL
    @State private var showingTerms = false
    @State private var showingPrivacy = false
    
    private let appStoreId = "YOUR_APP_STORE_ID" // Replace with your actual App Store ID
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode", systemImage: "moon.fill")
                }
                .tint(Color.accentColor)
            }
            
            Section {
                Button {
                    shareApp()
                } label: {
                    Label("Share App", systemImage: "square.and.arrow.up")
                }
                
                Button {
                    rateApp()
                } label: {
                    Label("Rate This App", systemImage: "star.fill")
                }
            }
            
            Section {
                Button {
                    showingTerms = true
                } label: {
                    Label("Terms of Use", systemImage: "doc.text")
                }
                
                Button {
                    showingPrivacy = true
                } label: {
                    Label("Privacy Policy", systemImage: "hand.raised.fill")
                }
            }
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $showingTerms) {
            TermsView()
        }
        .sheet(isPresented: $showingPrivacy) {
            PrivacyView()
        }
    }
    
    private func shareApp() {
        let appUrl = URL(string: "https://apps.apple.com/app/id\(appStoreId)")!
        let activityVC = UIActivityViewController(
            activityItems: ["Check out Bizpark!", appUrl],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            activityVC.popoverPresentationController?.sourceView = rootVC.view
            rootVC.present(activityVC, animated: true)
        }
    }
    
    private func rateApp() {
        let appStoreURL = URL(string: "https://apps.apple.com/app/id\(appStoreId)?action=write-review")!
        openURL(appStoreURL)
    }
}