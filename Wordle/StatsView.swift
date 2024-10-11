//
//  StatsView.swift
//  Wordle
//
//  Created by Maciej Kuczek on 20/02/2022.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var gameVM: GameVM
    
    var body: some View {
        VStack {
            VStack {
                Text("Statistics")
                    .font(.largeTitle)
                HStack(alignment: .top, spacing: 25) {
                    VStack {
                        Text("\(gameVM.timesPlayed)")
                            .font(.largeTitle)
                        Text("Played")
                    }
                    VStack {
                        Text(String(format: "%.0f", gameVM.winPercentage?.rounded() ?? 0))
                            .font(.largeTitle)
                        Text("Win %")
                    }
                    VStack {
                        Text("\(gameVM.currentStreak)")
                            .font(.largeTitle)
                        Text("Current\nStreak")
                            .multilineTextAlignment(.center)
                    }
                    VStack {
                        Text("\(gameVM.maxStreak)")
                            .font(.largeTitle)
                        Text("Max\nStreak")
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            if gameVM.winHistory.isEmpty {
                Text("No data")
            } else {
                VStack(alignment: .leading) {
                    ForEach(1..<7) { index in
                        HStack {
                            Text("\(index)")
                                .frame(width: 25)
                            GeometryReader { geo in
                                HStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(CGFloat(gameVM.winHistoryFrequence["\(index)"] ?? 0) == gameVM.frequenceScale ? .green : .gray)
                                    Text("\(gameVM.winHistoryFrequence["\(index)"] ?? 0)")
                                        .offset(x: -geo.size.width*0.08)
                                }
                                .frame(width: (CGFloat(gameVM.winHistoryFrequence["\(index)"] ?? 0)/gameVM.frequenceScale) * geo.size.width)
                            }
                            .frame(height: 30)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(GameVM())
    }
}
