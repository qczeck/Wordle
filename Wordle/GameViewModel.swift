//
//  GameViewModel.swift
//  Wordle
//
//  Created by Maciej Kuczek on 19/02/2022.
//

import Foundation
import SwiftUI

class GameVM: ObservableObject {
    @Published var game: Game
    
    init() {
        self.game = Game()
        self.stats = Stats()
    }
    
    var guesses: [Word] {
        game.guesses
    }
    
    var usedLetters: [String : LetterCheck] {
        game.usedLetters
    }
    
    var status: GameStatus {
        game.status
    }
    
    func convertCheckToColor(_ letterCheck: LetterCheck) -> Color {
        switch letterCheck {
        case .gray:
            return Color.gray
        case .orange:
            return Color.orange
        case .green:
            return Color.green
        }
    }
    
    //MARK: - Intent(s)
    
    func guess(_ word: String) {
        game.guess(word: Word(from: word))
        updateStats()
    }
    
    func restart() {
        game = Game()
    }
    
    //MARK: - Settings
    
    @Published var showCorrectWord = false
    @Published var showStatus = false
    
    //MARK: - Stats
    
    @Published var stats: Stats {
        didSet {
            self.stats.save()
        }
    }
    
    var timesPlayed: Int { stats.timesPlayed }
    var winHistory: [Int] { stats.winHistory }
    var currentStreak: Int { stats.currentStreak }
    var maxStreak: Int { stats.maxStreak }
    
    var winPercentage: Double? {
        if stats.timesPlayed != 0 {
            return 100 * Double(stats.winHistory.count) / Double(stats.timesPlayed)
        } else {
            return nil
        }
    }
    
    var winHistoryFrequence: [String : Int] {
        let mappedWinHistory = winHistory.map { ("\($0)", 1) }
        let counts = Dictionary(mappedWinHistory, uniquingKeysWith: +)
        return counts
    }
    
    var frequenceScale: CGFloat {
        var mostFrequentValue = 1
        
        for (_, frequency) in winHistoryFrequence {
            if frequency > mostFrequentValue {
                mostFrequentValue = frequency
            }
        }
        
        return CGFloat(mostFrequentValue)
    }
    
    func updateStats() {
        switch game.status {
        case let .won(tries):
            stats.winHistory.append(tries)
            stats.currentStreak += 1
            if maxStreak < currentStreak {
                stats.maxStreak = currentStreak
            }
            stats.timesPlayed += 1
        case .lost:
            stats.currentStreak = 0
            stats.timesPlayed += 1
        case .inProgress:
            break
        }
    }
    
    func resetStats() {
        stats.reset()
    }
}
