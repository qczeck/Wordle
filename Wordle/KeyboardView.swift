//
//  KeyboardView.swift
//  Wordle
//
//  Created by Maciej Kuczek on 19/02/2022.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var gameVM: GameVM
    
    @Binding var word: String
    var returnAction: () -> Void
    
    var keys = [["Q","W","E","R","T","Y","U","I","O","P"],["A","S","D","F","G","H","J","K","L"],["return","Z","X","C","V","B","N","M","delete.left"]]
    
    func colorForLetter(_ letter: String) -> Color {
        if let letterCheck = gameVM.usedLetters[letter] {
            return gameVM.convertCheckToColor(letterCheck)
        } else {
            return .primary
        }
    }
    
    var body: some View {
        VStack {
            ForEach(keys, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { letter in
                        if letter.count == 1 {
                            Button {
                                word.append(letter)
                            } label: {
                                Text(letter)
                                    .foregroundColor(colorForLetter(letter))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(colorForLetter(letter), lineWidth: 1)
                                    )
                                    
                            }
                        } else if letter == "return" {
                            Button {
                                returnAction()
                            } label: {
                                Image(systemName: letter)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 1)
                                    )
                                    .foregroundColor(.primary)
                            }
                        } else {
                            Button {
                                word.removeLast()
                            } label: {
                                Image(systemName: letter)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 1)
                                    )
                                    .foregroundColor(.primary)
                            }
                            .disabled(word.count == 0)
                        }
                    }
                }
            }
        }
    }
}

//struct KeyboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyboardView()
//    }
//}
