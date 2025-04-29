import SwiftUI

struct IdeaCardView: View {
    let idea: BusinessIdea
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(idea.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .primary)
            
            Text(idea.description)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .secondary)
                .lineLimit(3)
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .secondary)
                Text(idea.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.6) : .secondary)
                
                Spacer()
                
                if let budget = idea.budget {
                    Text(String(format: "$%.2f", budget))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colorScheme == .dark ? Color.green.opacity(0.2) : Color.green.opacity(0.1))
                        )
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? 
                    Color(UIColor.systemGray6) : Color(.systemBackground))
                .shadow(
                    color: colorScheme == .dark ? 
                        Color.white.opacity(0.05) : Color.black.opacity(0.1),
                    radius: 10,
                    x: 0,
                    y: 5
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    colorScheme == .dark ? 
                        Color.white.opacity(0.1) : Color.clear,
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}