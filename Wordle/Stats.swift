//
//  Stats.swift
//  Wordle
//
//  Created by Maciej Kuczek on 20/02/2022.
//

import Foundation

struct Stats: Codable {
    var timesPlayed: Int
    var winHistory: [Int]
    var currentStreak: Int
    var maxStreak: Int
    
    static let savePath = FileManager.getDocumentsDirectory().appendingPathComponent("stats")
    
    init() {
        do {
            let data = try Data(contentsOf: Stats.savePath)
            self = try JSONDecoder().decode(Stats.self, from: data)
        } catch {
            timesPlayed = 0
            winHistory = []
            currentStreak = 0
            maxStreak = 0
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: Stats.savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    mutating func reset() {
        timesPlayed = 0
        winHistory = []
        currentStreak = 0
        maxStreak = 0
    }
}
