//
//  SessionView.swift
//  Metta
//
//  Meditation session screen
//  Metta Labs Brand System Applied
//

import SwiftUI

struct SessionView: View {
    @State private var selectedDuration = 5
    @State private var isSessionActive = false
    @State private var timeRemaining = 300
    
    let durations = [3, 5, 10, 15, 20]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dark
                    .ignoresSafeArea()
                
                if isSessionActive {
                    activeSessionView
                } else {
                    setupView
                }
            }
            .navigationTitle("Meditate")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var setupView: some View {
        VStack(spacing: MettaSpacing.xl) {
            // Metta phrase - Brand Gold
            VStack(spacing: MettaSpacing.sm) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.mettaGold)  // Brand
                    .mettaGoldAccent()
                
                Text("Metta Meditation")
                    .font(MettaTypography.title1)
                    .foregroundColor(.cream)
                
                Text("May all beings be happy")
                    .font(MettaTypography.subheadline)
                    .foregroundColor(.lightGray)
            }
            .padding(.top, MettaSpacing.xxxl)
            
            // Duration selector
            VStack(spacing: MettaSpacing.md) {
                Text("Duration")
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.cream)
                
                HStack(spacing: MettaSpacing.sm + 4) {
                    ForEach(durations, id: \.self) { duration in
                        Button(action: { selectedDuration = duration }) {
                            Text("\(duration)")
                                .font(MettaTypography.bodyBold)
                                .foregroundColor(selectedDuration == duration ? .dark : .cream)
                                .frame(width: 50, height: 50)
                                .background(
                                    selectedDuration == duration
                                    ? Color.mettaGold  // Brand
                                    : Color.cream.opacity(0.05)
                                )
                                .cornerRadius(25)
                        }
                    }
                }
                
                Text("\(selectedDuration) minutes")
                    .font(MettaTypography.subheadline)
                    .foregroundColor(.lightGray)
            }
            
            Spacer()
            
            // Start button - Brand Gold
            Button(action: startSession) {
                Text("Begin Practice")
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.dark)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, MettaSpacing.md + 2)
                    .background(Color.mettaGold)  // Brand
                    .cornerRadius(MettaCornerRadius.medium)
            }
            .padding(.horizontal, MettaSpacing.screenPadding)
            .padding(.bottom, MettaSpacing.xxxl)
        }
    }
    
    private var activeSessionView: some View {
        VStack(spacing: MettaSpacing.xxl) {
            Spacer()
            
            // Breathing circle - Brand Gold
            ZStack {
                Circle()
                    .stroke(Color.mettaGold.opacity(0.3), lineWidth: 4)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .fill(Color.mettaGold.opacity(0.2))
                    .frame(width: 160, height: 160)
                
                VStack(spacing: MettaSpacing.xs) {
                    Text(timeString)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.cream)
                    
                    Text("Breathe")
                        .font(MettaTypography.subheadline)
                        .foregroundColor(.lightGray)
                }
            }
            
            // Metta phrase
            Text("May I be happy, may I be healthy")
                .font(MettaTypography.title3)
                .foregroundColor(.cream)
                .multilineTextAlignment(.center)
                .padding(.horizontal, MettaSpacing.xxl)
            
            Spacer()
            
            // End button
            Button(action: { isSessionActive = false }) {
                Text("End Session")
                    .font(MettaTypography.bodyBold)
                    .foregroundColor(.red)
                    .padding(.vertical, MettaSpacing.md)
            }
            .padding(.bottom, MettaSpacing.xxxl)
        }
    }
    
    private var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func startSession() {
        isSessionActive = true
        timeRemaining = selectedDuration * 60
    }
}

#Preview {
    SessionView()
}
