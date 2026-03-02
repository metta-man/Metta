//
//  HomeView.swift
//  Metta
//
//  Home screen with daily greeting and quick start
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
                // Dark background
                Color(hex: "121214")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        headerSection
                        
                        // Daily card
                        dailyCard
                        
                        // Streak section
                        streakSection
                        
                        // Quick start
                        quickStartSection
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Metta")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(greeting)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Ready for your practice?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dailyCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundColor(Color(hex: "2DD4BF"))
                
                Text("Today's Metta")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                if todayCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            
            Text("May I be happy, may I be healthy, may I be at peace.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {}) {
                Text(todayCompleted ? "Completed ✓" : "Start Practice")
                    .font(.headline)
                    .foregroundColor(Color(hex: "121214"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        todayCompleted 
                        ? Color.gray.opacity(0.3)
                        : Color(hex: "2DD4BF")
                    )
                    .cornerRadius(12)
            }
            .disabled(todayCompleted)
        }
        .padding(20)
        .background(Color(hex: "1A1D26"))
        .cornerRadius(16)
    }
    
    private var streakSection: some View {
        HStack(spacing: 16) {
            StreakCard(title: "Current", value: "\(currentStreak)", icon: "flame.fill", color: .orange)
            StreakCard(title: "Total", value: "12", icon: "star.fill", color: Color(hex: "2DD4BF"))
            StreakCard(title: "Days", value: "8", icon: "calendar", color: .purple)
        }
    }
    
    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Start")
                .font(.headline)
                .foregroundColor(.white)
            
            QuickStartButton(duration: "3 min", title: "Short") {
                // Start 3 min session
            }
            
            QuickStartButton(duration: "5 min", title: "Standard") {
                // Start 5 min session
            }
            
            QuickStartButton(duration: "10 min", title: "Extended") {
                // Start 10 min session
            }
        }
    }
}

struct StreakCard: View {
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
                .font(.title)
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

struct QuickStartButton: View {
    let duration: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(duration)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(16)
            .background(Color(hex: "1A1D26"))
            .cornerRadius(12)
        }
    }
}

#Preview {
    HomeView()
}
