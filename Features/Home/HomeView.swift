//
//  HomeView.swift
//  Metta
//
//  Home screen with daily greeting and quick start
//  Metta Labs Brand System Applied
//

import SwiftUI

struct HomeView: View {
    @State private var currentStreak = 0
    @State private var todayCompleted = false
    
    private let greeting: String = {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Brand: Cream background (dark mode: dark)
                Color.dark
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: MettaSpacing.lg) {
                        // Header
                        headerSection
                        
                        // Daily card
                        dailyCard
                        
                        // Streak section
                        streakSection
                        
                        // Quick start
                        quickStartSection
                    }
                    .padding(MettaSpacing.screenPadding)
                }
            }
            .navigationTitle("Metta")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: MettaSpacing.xxs) {
            Text(greeting)
                .font(MettaTypography.subheadline)
                .foregroundColor(.lightGray)
            
            Text("Ready for your practice?")
                .font(MettaTypography.title2)
                .fontWeight(.medium)
                .foregroundColor(.cream)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dailyCard: some View {
        VStack(alignment: .leading, spacing: MettaSpacing.md) {
            HStack {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundColor(.mettaGold)  // Brand accent
                
                Text("Today's Metta")
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.cream)
                
                Spacer()
                
                if todayCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            
            Text("May I be happy, may I be healthy, may I be at peace.")
                .font(MettaTypography.body)
                .foregroundColor(.lightGray)
            
            Button(action: {}) {
                Text(todayCompleted ? "Completed ✓" : "Start Practice")
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.dark)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, MettaSpacing.sm + 2)
                    .background(
                        todayCompleted 
                        ? Color.lightGray.opacity(0.3)
                        : Color.mettaGold  // Brand primary
                    )
                    .cornerRadius(MettaCornerRadius.medium)
            }
            .disabled(todayCompleted)
        }
        .padding(MettaSpacing.cardPadding)
        .background(Color.cream.opacity(0.05))  // Subtle card
        .cornerRadius(MettaCornerRadius.large)
    }
    
    private var streakSection: some View {
        HStack(spacing: MettaSpacing.md) {
            StreakCard(title: "Current", value: "\(currentStreak)", icon: "flame.fill", color: .orange)
            StreakCard(title: "Total", value: "12", icon: "star.fill", color: .mettaGold)  // Brand
            StreakCard(title: "Days", value: "8", icon: "calendar", color: .purple)
        }
    }
    
    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: MettaSpacing.sm) {
            Text("Quick Start")
                .font(MettaTypography.bodyBold)
                .foregroundColor(.cream)
            
            QuickStartButton(duration: "3 min", title: "Short") {}
            QuickStartButton(duration: "5 min", title: "Standard") {}
            QuickStartButton(duration: "10 min", title: "Extended") {}
        }
    }
}

struct StreakCard: View {
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
                .font(MettaTypography.title2)
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

struct QuickStartButton: View {
    let duration: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(duration)
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.cream)
                
                Spacer()
                
                Text(title)
                    .font(MettaTypography.subheadline)
                    .foregroundColor(.lightGray)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.lightGray)
            }
            .padding(MettaSpacing.md)
            .background(Color.cream.opacity(0.05))
            .cornerRadius(MettaCornerRadius.medium)
        }
    }
}

#Preview {
    HomeView()
}
