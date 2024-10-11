//
//  WordleApp.swift
//  Wordle
//
//  Created by Maciej Kuczek on 14/02/2022.
//

import SwiftUI

@main
struct WordleApp: App {
    @StateObject var gameVM = GameVM()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameVM)
        }
    }
}
