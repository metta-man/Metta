//
//  SessionView.swift
//  Metta
//
//  Meditation session screen
//

import SwiftUI

struct SessionView: View {
    @State private var selectedDuration = 5 // minutes
    @State private var isSessionActive = false
    @State private var timeRemaining = 300 // seconds
    
    let durations = [3, 5, 10, 15, 20]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "121214")
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
        VStack(spacing: 32) {
            // Metta phrase
            VStack(spacing: 12) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color(hex: "2DD4BF"))
                
                Text("Metta Meditation")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("May all beings be happy")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 40)
            
            // Duration selector
            VStack(spacing: 16) {
                Text("Duration")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    ForEach(durations, id: \.self) { duration in
                        Button(action: {
                            selectedDuration = duration
                        }) {
                            Text("\(duration)")
                                .font(.headline)
                                .foregroundColor(selectedDuration == duration ? Color(hex: "121214") : .white)
                                .frame(width: 50, height: 50)
                                .background(
                                    selectedDuration == duration
                                    ? Color(hex: "2DD4BF")
                                    : Color(hex: "1A1D26")
                                )
                                .cornerRadius(25)
                        }
                    }
                }
                
                Text("\(selectedDuration) minutes")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Start button
            Button(action: {
                startSession()
            }) {
                Text("Begin Practice")
                    .font(.headline)
                    .foregroundColor(Color(hex: "121214"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(hex: "2DD4BF"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
    
    private var activeSessionView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Breathing circle
            ZStack {
                Circle()
                    .stroke(Color(hex: "2DD4BF").opacity(0.3), lineWidth: 4)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .fill(Color(hex: "2DD4BF").opacity(0.2))
                    .frame(width: 160, height: 160)
                
                VStack(spacing: 8) {
                    Text(timeString)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Breathe")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            // Metta phrase
            Text("May I be happy, may I be healthy")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // End button
            Button(action: {
                isSessionActive = false
            }) {
                Text("End Session")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(.vertical, 16)
            }
            .padding(.bottom, 40)
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
