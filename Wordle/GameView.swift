//
//  GameView.swift
//  Wordle
//
//  Created by Maciej Kuczek on 14/02/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameVM: GameVM
    
    @State private var word = ""
    
    @State private var wordNotInList = false
    @State private var wordNotFiveLetters = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                if gameVM.showCorrectWord {
                    HStack {
                        ForEach(0..<gameVM.game.currentWord.count) { index in
                            Text(gameVM.game.currentWord[index])
                                .foregroundColor(.red)
                        }
                    }
                }
                
                if gameVM.showStatus {
                    switch gameVM.status {
                    case .inProgress:
                        Text("In progress")
                    case let .won(tries):
                        Text("Won in \(tries) \(tries == 1 ? "try" : "tries")")
                    case .lost:
                        Text("Lost")
                    }
                }
                
                //THIS WORKS, SO KEEP IT IN CASE INDEX-RELATED ISSUES ARISE
//                ForEach(gameVM.guesses) { guess in
//                    GuessCell(guess: guess)
//                }
                
                ForEach(0..<6) { index in
                    if index < gameVM.guesses.count {
                        GuessCell(guess: gameVM.guesses[index])
                            
                    } else {
                        EmptyGuessCell()
                    }
                }
                
                Spacer()
                
                if gameVM.status == .inProgress {
                    Text(word)
                        .font(.largeTitle)
                } else if gameVM.status == .lost {
                    Text("Correct word: \(gameVM.game.currentWord.joined())")
                        .font(.largeTitle)
                }
                
                KeyboardView(word: $word) {
                    if word.count != 5{
                        wordNotFiveLetters = true
                    } else if !Game.wordList.contains(word.uppercased()) {
                        wordNotInList = true
                    } else {
                        if word.count == 5 && Game.wordList.contains(word.uppercased()) {
                            withAnimation {
                                gameVM.guess(word.uppercased())
                            }
                        }
                    }
                    word = ""
                }
                    .font(.title)
                    .disabled(gameVM.status != .inProgress)
                    .alert("Word not in the word list", isPresented: $wordNotInList) { }
                    .alert("Word must be five letters long", isPresented: $wordNotFiveLetters) { }
                Spacer()
                    .frame(height: 30)
            }
            .navigationTitle("Wordle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StatsView()) {
                        Label("Stats", systemImage: "chart.bar.doc.horizontal")
                    }
                    
                    Button {
                        showSettingsSheet = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            gameVM.restart()
                        }
                        word = ""
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            }
            .sheet(isPresented: $showSettingsSheet) {
                SettingsSheet()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameVM())
    }
}
