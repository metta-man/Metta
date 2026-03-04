//
//  ContentView.swift
//  Metta
//
//  Main app view - Metta Labs Brand System Applied
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "heart.fill")
                }
                .tag(0)
            
            SessionView()
                .tabItem {
                    Label("Meditate", systemImage: "figure.mind.and.body")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "chart.bar.fill")
                }
                .tag(2)
        }
        // Metta Gold accent color - Brand System
        .tint(Color.mettaGold)
    }
}

#Preview {
    ContentView()
}
