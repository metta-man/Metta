//
//  StorageService.swift
//  Metta
//
//  Local storage for sessions
//

import Foundation

final class StorageService {
    static let shared = StorageService()
    
    private let sessionsKey = "metta_sessions"
    
    private init() {}
    
    func saveSession(_ session: MettaSession) {
        var sessions = getSessions()
        sessions.append(session)
        
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: sessionsKey)
        }
    }
    
    func getSessions() -> [MettaSession] {
        guard let data = UserDefaults.standard.data(forKey: sessionsKey),
              let sessions = try? JSONDecoder().decode([MettaSession].self, from: data) else {
            return []
        }
        return sessions.sorted { $0.date > $1.date }
    }
    
    func getStreak() -> Int {
        let sessions = getSessions()
        guard !sessions.isEmpty else { return 0 }
        
        var streak = 0
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: Date())
        
        while true {
            let hasSession = sessions.contains { calendar.isDate($0.date, inSameDayAs: currentDate) }
            
            if hasSession {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else if calendar.isDateInToday(currentDate) {
                // Skip today if not done yet
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else {
                break
            }
        }
        
        return streak
    }
}
