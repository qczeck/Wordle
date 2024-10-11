//
//  SettingsSheet.swift
//  Wordle
//
//  Created by Maciej Kuczek on 19/02/2022.
//

import SwiftUI

struct SettingsSheet: View {
    @EnvironmentObject var gameVM: GameVM
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section("Debug only") {
                    Toggle("Show correct word on top", isOn: $gameVM.showCorrectWord)
                    Toggle("Show the status of the game", isOn: $gameVM.showStatus)
                }
                HStack {
                    Spacer()
                    Button {
                        gameVM.resetStats()
                    } label: {
                        Text("Reset stats")
                    }
                    .foregroundColor(.red)
                    Spacer()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct SettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheet()
            .environmentObject(GameVM())
    }
}
