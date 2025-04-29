import SwiftUI

struct PrivacyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Privacy Policy")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Last Updated: \(Date().formatted(date: .long, time: .omitted))")
                            .foregroundColor(.secondary)
                        
                        Text("Data Collection")
                            .font(.headline)
                        Text("Bizpark does not collect any personal information. All business ideas are stored locally on your device.")
                        
                        Text("Data Storage")
                            .font(.headline)
                        Text("Your business ideas are stored securely on your device and are not transmitted to any external servers.")
                        
                        Text("Third-Party Services")
                            .font(.headline)
                        Text("We do not share any information with third-party services or analytics providers.")
                        
                        Text("Changes to Privacy Policy")
                            .font(.headline)
                        Text("We reserve the right to update our Privacy Policy. Any changes will be reflected on this page.")
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}