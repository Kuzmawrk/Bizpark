import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: BusinessIdeasViewModel
    
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
                    VStack(spacing: 20) {
                        // Total Ideas Card
                        StatCard(
                            title: "Total Ideas",
                            value: "\(viewModel.ideas.count)",
                            icon: "lightbulb.fill",
                            color: .yellow
                        )
                        
                        // Ideas with Budget Card
                        StatCard(
                            title: "Ideas with Budget",
                            value: "\(viewModel.ideas.filter { $0.budget != nil }.count)",
                            icon: "dollarsign.circle.fill",
                            color: .green
                        )
                        
                        // Average Budget Card
                        StatCard(
                            title: "Average Budget",
                            value: averageBudget,
                            icon: "chart.bar.fill",
                            color: .blue
                        )
                        
                        // Latest Ideas Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Latest Ideas")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(Array(viewModel.ideas.prefix(3))) { idea in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(idea.title)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text(idea.createdAt.formatted(date: .abbreviated, time: .shortened))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    if let budget = idea.budget {
                                        Text("$\(String(format: "%.2f", budget))")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Statistics")
        }
    }
    
    private var averageBudget: String {
        let ideasWithBudget = viewModel.ideas.compactMap { $0.budget }
        guard !ideasWithBudget.isEmpty else { return "$0" }
        let average = ideasWithBudget.reduce(0, +) / Double(ideasWithBudget.count)
        return "$\(String(format: "%.2f", average))"
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}