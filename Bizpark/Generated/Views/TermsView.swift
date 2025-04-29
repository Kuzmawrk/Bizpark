import SwiftUI

struct TermsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Terms of Use")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Last Updated: \(Date().formatted(date: .long, time: .omitted))")
                            .foregroundColor(.secondary)
                        
                        Text("1. Acceptance of Terms")
                            .font(.headline)
                        Text("By accessing and using Bizpark, you accept and agree to be bound by the terms and provision of this agreement.")
                        
                        Text("2. Use License")
                            .font(.headline)
                        Text("This is a personal, non-exclusive, non-transferable license to use Bizpark for storing and managing your business ideas.")
                        
                        Text("3. Disclaimer")
                            .font(.headline)
                        Text("The app is provided 'as is' without warranties of any kind, either expressed or implied.")
                        
                        Text("4. Limitations")
                            .font(.headline)
                        Text("You may not: (a) modify or copy the materials; (b) use the materials for any commercial purpose; (c) attempt to decompile or reverse engineer any software contained in Bizpark.")
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