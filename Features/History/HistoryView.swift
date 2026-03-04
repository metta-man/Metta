//
//  HistoryView.swift
//  Metta
//
//  Session history and stats
//  Metta Labs Brand System Applied
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dark
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: MettaSpacing.lg) {
                        // Stats header
                        statsHeader
                        
                        // Calendar heatmap placeholder
                        calendarSection
                        
                        // Recent sessions
                        recentSessionsSection
                    }
                    .padding(MettaSpacing.screenPadding)
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var statsHeader: some View {
        HStack(spacing: MettaSpacing.md) {
            StatCard(title: "Total Sessions", value: "24", icon: "figure.mind.and.body", color: .mettaGold)
            StatCard(title: "Total Time", value: "2h 15m", icon: "clock.fill", color: .orange)
            StatCard(title: "Current Streak", value: "5", icon: "flame.fill", color: .red)
        }
    }
    
    private var calendarSection: some View {
        VStack(alignment: .leading, spacing: MettaSpacing.sm) {
            Text("This Month")
                .font(MettaTypography.bodyBold)
                .foregroundColor(.cream)
            
            // Simple calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: MettaSpacing.xs) {
                ForEach(0..<35, id: \.self) { index in
                    let day = index - 5
                    let isActive = [1, 2, 3, 4, 6, 8, 9, 11, 12, 14, 15, 16, 18, 20, 21, 23, 25].contains(day)
                    let isToday = day == 6
                    
                    Circle()
                        .fill(isActive ? Color.mettaGold : Color.cream.opacity(0.05))  // Brand
                        .frame(width: 36, height: 36)
                        .overlay(
                            Text("\(day > 0 && day <= 28 ? "\(day)" : "")")
                                .font(MettaTypography.caption)
                                .foregroundColor(day == 6 ? .dark : .lightGray)
                        )
                }
            }
            .padding(MettaSpacing.md)
            .background(Color.cream.opacity(0.05))
            .cornerRadius(MettaCornerRadius.medium)
        }
    }
    
    private var recentSessionsSection: some View {
        VStack(alignment: .leading, spacing: MettaSpacing.sm) {
            Text("Recent Sessions")
                .font(MettaTypography.bodyBold)
                .foregroundColor(.cream)
            
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
        VStack(spacing: MettaSpacing.xs) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(MettaTypography.title3)
                .fontWeight(.medium)
                .foregroundColor(.cream)
            
            Text(title)
                .font(MettaTypography.caption)
                .foregroundColor(.lightGray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, MettaSpacing.md)
        .background(Color.cream.opacity(0.05))
        .cornerRadius(MettaCornerRadius.medium)
    }
}

struct SessionRow: View {
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(.mettaGold)  // Brand
                .frame(width: 40, height: 40)
                .background(Color.mettaGold.opacity(0.2))
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Metta Meditation")
                    .font(MettaTypography.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.cream)
                
                Text("5 minutes")
                    .font(MettaTypography.caption)
                    .foregroundColor(.lightGray)
            }
            
            Spacer()
            
            Text("Today")
                .font(MettaTypography.caption)
                .foregroundColor(.lightGray)
        }
        .padding(MettaSpacing.sm + 4)
        .background(Color.cream.opacity(0.05))
        .cornerRadius(MettaCornerRadius.medium)
    }
}

#Preview {
    HistoryView()
}
