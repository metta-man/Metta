//
//  Session.swift
//  Metta
//
//  Session model
//

import Foundation

struct MettaSession: Identifiable, Codable {
    let id: UUID
    let date: Date
    let durationMinutes: Int
    let completed: Bool
    
    init(id: UUID = UUID(), date: Date = Date(), durationMinutes: Int, completed: Bool = true) {
        self.id = id
        self.date = date
        self.durationMinutes = durationMinutes
        self.completed = completed
    }
}

struct DailyEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let gratitude1: String
    let gratitude2: String
    let gratitude3: String
    let mettaCompleted: Bool
    
    init(id: UUID = UUID(), date: Date = Date(), gratitude1: String, gratitude2: String, gratitude3: String, mettaCompleted: Bool = false) {
        self.id = id
        self.date = date
        self.gratitude1 = gratitude1
        self.gratitude2 = gratitude2
        self.gratitude3 = gratitude3
        self.mettaCompleted = mettaCompleted
    }
}
