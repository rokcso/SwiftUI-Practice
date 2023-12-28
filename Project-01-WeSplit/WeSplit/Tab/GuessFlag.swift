//
//  GuessFlag.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/25.
//

import SwiftUI

struct GuessFlag: View {
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var yesCountry: Int = Int.random(in: 0...2)
    @State private var showAlert: Bool = false
    @State private var showTitle: String = ""
    @State private var showMsg: String = ""
    @State private var score: Int = 0
    @State private var gameTimes: Int = 8
    
    var body: some View {
        ZStack() {
            Color.gray
                .ignoresSafeArea()
            
//            LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            
            VStack() {
                Spacer()
                VStack(spacing: 10) {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.bold))
                    Text(countries[yesCountry])
                        .font(.largeTitle.weight(.bold))
                }
                .foregroundStyle(.white)
                
                Spacer()
                VStack() {
                    ForEach(0..<3) {
                        num in
                        Button {
                            check(num)
                        } label: {
                            Image(countries[num])
                        }
                    }
                }
                
                Spacer()
                Spacer()
                VStack() {
                    HStack() {
                        Text("Times: \(gameTimes)")
                            .font(.title.weight(.bold))
                        Text("Score: \(score)")
                            .font(.title.weight(.bold))
                    }
                    
                    Button {
                        restart()
                    } label: {
                        Text("Restart")
                            .background(.white)
                            .foregroundColor(.black)
                            .padding()
                            .font(.subheadline.weight(.medium))
                    }
                }
                Spacer()
            }
        }
        .alert(showTitle, isPresented: $showAlert) {
            Button("Continue", action: renew)
        } message: {
            Text(showMsg)
        }
    }
    
    func renew() {
        countries.shuffle()
    }
    
    func restart() {
        score = 0
        gameTimes = 8
        showAlert = true
        showTitle = "重置游戏？"
        showMsg = "当前成绩和进度都将清空"
    }
    
    func check(_ num: Int) {
        gameTimes -= 1
        if gameTimes > 0 {
            if num == yesCountry {
                score += 1
                showTitle = "答对了"
                showMsg = "现在请继续，你还有 \(gameTimes) 次游戏机会"
            } else {
                score -= 1
                showTitle = "哦豁，答错了"
                showMsg = "淦，这是 \(countries[num])"
            }
        } else {
            if num == yesCountry {
                score += 1
                showTitle = "答对了"
                showMsg = "游戏结束，你的成绩是 \(score) 分"
            } else {
                score -= 1
                showTitle = "哦豁，答错了"
                showMsg = "淦，这是 \(countries[num])，游戏结束，你的成绩是 \(score) 分"
            }
            restart()
        }
        showAlert = true
    }
}

#Preview {
    GuessFlag()
}
