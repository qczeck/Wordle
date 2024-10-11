//
//  GuessCell.swift
//  Wordle
//
//  Created by Maciej Kuczek on 20/02/2022.
//

import SwiftUI

struct GuessCell: View {
    @EnvironmentObject var gameVM: GameVM
    var guess: Word
    
    var body: some View {
        HStack {
            ForEach(0..<guess.letters.count) { index in
                Text(guess.letters[index].0)
                    .foregroundColor(gameVM.convertCheckToColor(guess.letters[index].1))
                    .font(.largeTitle)
                    .frame(width: 50, height: 50, alignment: .center)
                    .border(gameVM.convertCheckToColor(guess.letters[index].1))
            }
        }
    }
}

struct EmptyGuessCell: View {
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Text("Z")
                    .opacity(0)
                    .font(.largeTitle)
                    .frame(width: 50, height: 50, alignment: .center)
                    .border(.gray)
            }
        }
    }
}

struct EmptyGuessCells: View {
    var body: some View {
        VStack {
            ForEach(1..<7) { _ in
                HStack {
                    ForEach(0..<5) { _ in
                        Text("Z")
                            .opacity(0)
                            .font(.largeTitle)
                            .frame(width: 50, height: 50, alignment: .center)
                            .border(.gray)
                    }
                }
            }
        }
    }
}

struct GuessCell_Previews: PreviewProvider {
    static var previews: some View {
        GuessCell(guess: Word(from: "CRANE"))
            .previewLayout(.fixed(width: 400, height: 100))
            .environmentObject(GameVM())
        EmptyGuessCells()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
