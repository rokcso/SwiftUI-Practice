//
//  RockPaperScissors.swift
//  WeSplit
//
//  Created by rokcso on 2024/1/1.
//

import SwiftUI

struct RockPaperScissors: View {
    private let gestureList: [String] = ["✊", "✋", "✌️"]
    private let resultList: [String] = ["Win", "Lose"]
    @State private var appChoseGesture: Int = Int.random(in: 0..<3)
    @State private var appChoseResult: Int = Int.random(in: 0..<2)
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    @State private var gameTimes: Int = 10
    
    var body: some View {
        VStack() {
            Spacer()
            HStack() {
                Spacer()
                Text(gestureList[appChoseGesture])
                    .font(.title.weight(.bold))
                Spacer()
                Text(resultList[appChoseResult])
                    .font(.title.weight(.bold))
                Spacer()
            }
            Spacer()
            Text("SCORE: \(score)")
                .font(.title.weight(.light))
            Spacer()
            HStack() {
                Spacer()
                ForEach(0..<3) {
                    num in
                    Button() {
                        check(num)
                        update()
                    } label: {
                        Text(gestureList[num])
                            .font(.title.weight(.bold))
                    }
                    .frame(width: 80, height: 60)
                    .background(.red)
                    Spacer()
                }
            }
            Spacer()
        }
        .alert("Game Over", isPresented: $showResult) {
            Button("OK", action: restart)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func restart() {
        update()
        score = 0
        gameTimes = 10
    }
    
    func update() {
        appChoseGesture = Int.random(in: 0..<3)
        appChoseResult = Int.random(in: 0..<2)
    }
    
    func check(_ num: Int) {
        gameTimes -= 1
        if appChoseResult == 0 {
            // Win
            switch appChoseGesture {
            case 0:
                // Rock -> Paper
                if num == 1 {
                    score += 1
                } else {
                    score -= 1
                }
            case 1:
                // Paper -> Scissors
                if num == 2 {
                    score += 1
                } else {
                    score -= 1
                }
            case 2:
                // Scissors -> Rock
                if num == 0 {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                score = 404
            }
        } else {
            // Lose
            switch appChoseGesture {
            case 0:
                // Rock -> Scissors
                if num == 2 {
                    score += 1
                } else {
                    score -= 1
                }
            case 1:
                // Paper -> Rock
                if num == 0 {
                    score += 1
                } else {
                    score -= 1
                }
            case 2:
                // Scissors -> Paper
                if num == 1 {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                score = 404
            }
        }
        if gameTimes <= 0 {
            showResult = true
        }
    }
}

#Preview {
    RockPaperScissors()
}
