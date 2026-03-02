//
//  HistoryView.swift
//  Metta
//
//  Session history and stats
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "121214")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Stats header
                        statsHeader
                        
                        // Calendar heatmap placeholder
                        calendarSection
                        
                        // Recent sessions
                        recentSessionsSection
                    }
                    .padding(20)
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var statsHeader: some View {
        HStack(spacing: 16) {
            StatCard(title: "Total Sessions", value: "24", icon: "figure.mind.and.body", color: Color(hex: "2DD4BF"))
            StatCard(title: "Total Time", value: "2h 15m", icon: "clock.fill", color: .orange)
            StatCard(title: "Current Streak", value: "5", icon: "flame.fill", color: .red)
        }
    }
    
    private var calendarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This Month")
                .font(.headline)
                .foregroundColor(.white)
            
            // Simple calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(0..<35, id: \.self) { index in
                    let day = index - 5 // offset for day of week
                    let isActive = [1, 2, 3, 4, 6, 8, 9, 11, 12, 14, 15, 16, 18, 20, 21, 23, 25].contains(day)
                    let isToday = day == 6
                    
                    Circle()
                        .fill(isActive ? Color(hex: "2DD4BF") : Color(hex: "1A1D26"))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Text("\(day > 0 && day <= 28 ? "\(day)" : "")")
                                .font(.caption)
                                .foregroundColor(day == 6 ? .black : .gray)
                        )
                }
            }
            .padding(16)
            .background(Color(hex: "1A1D26"))
            .cornerRadius(12)
        }
    }
    
    private var recentSessionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Sessions")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(0..<5, id: \.self) { _ in
                SessionRow()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(hex: "1A1D26"))
        .cornerRadius(12)
    }
}

struct SessionRow: View {
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(Color(hex: "2DD4BF"))
                .frame(width: 40, height: 40)
                .background(Color(hex: "2DD4BF").opacity(0.2))
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Metta Meditation")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Text("5 minutes")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("Today")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(Color(hex: "1A1D26"))
        .cornerRadius(12)
    }
}

#Preview {
    HistoryView()
}
