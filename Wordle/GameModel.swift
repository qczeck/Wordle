//
//  GameModel.swift
//  Wordle
//
//  Created by Maciej Kuczek on 19/02/2022.
//

import Foundation
import SwiftUI

struct Game {
    static var wordList: [String] {
        if let filepath = Bundle.main.path(forResource: "wordlist", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath)
                return data.uppercased().components(separatedBy: "\n")
            } catch {
                print("Contents could not be loaded")
                return ["ERROR"]
            }
        } else {
            print("Text file not found")
            return ["ERROR"]
        }
    }
    var currentWord: [String]
    
    init() {
        if let word = Game.wordList.randomElement() {
            currentWord = word.map { String($0) }
        } else {
            currentWord = ["E", "R", "R", "O", "R"]
        }
    }
    
    var guesses: [Word] = []
    
    var usedLetters: [String : LetterCheck] = [:]

    mutating func guess(word: Word) {
        var guessedWord = word
        
        for i in 0...4 {
            if guessedWord.letters[i].0 == currentWord[i] {
                guessedWord.letters[i].1 = .green
                usedLetters[guessedWord.letters[i].0] = .green
                
            } else if currentWord.contains(guessedWord.letters[i].0) {
                guessedWord.letters[i].1 = .orange
                if usedLetters[guessedWord.letters[i].0] != .green {
                    usedLetters[guessedWord.letters[i].0] = .orange
                }
            } else {
                if usedLetters[guessedWord.letters[i].0] != .green || usedLetters[guessedWord.letters[i].0] != .orange {
                    usedLetters[guessedWord.letters[i].0] = .gray
                }
            }
        }
        
        guesses.append(guessedWord)
    }
    
    var status: GameStatus {
        func isWordFullyCorrect(_ word: Word) -> Bool {
            var fullyCorrect = true
            
            for i in 0...4 {
                if word.letters[i].1 != .green {
                    fullyCorrect = false
                }
            }
            
            return fullyCorrect
        }
        
        if let lastGuess = guesses.last {
            if guesses.count == 6 {
                if isWordFullyCorrect(lastGuess) {
                    return .won(6)
                } else {
                    return .lost
                }
            } else {
                if isWordFullyCorrect(lastGuess) {
                    return .won(guesses.count)
                } else {
                    return .inProgress
                }
            }
        } else {
            return .inProgress
        }
    }
}

struct Word: Identifiable {
    let id = UUID()
    fileprivate(set) var letters: [(String, LetterCheck)]
    
    init(from string: String) {
        letters = string.map { (String($0),.gray) }
    }
}

enum LetterCheck: Equatable {
    case gray //miss
    case orange //contains but incorrect place
    case green //contains and correct place
}

enum GameStatus: Equatable {
    case inProgress
    case lost
    case won(Int) //associated value is the number of attempts required
}
