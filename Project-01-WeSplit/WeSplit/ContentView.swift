//
//  ContentView.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TipCalculator()
                .tabItem {
                    Label("Tip", systemImage: "number.circle.fill")
                }
            UnitConverter()
                .tabItem {
                    Label("Unit", systemImage: "arrow.clockwise.circle.fill")
                }
            GuessFlag()
                .tabItem {
                    Label("Guess", systemImage: "flag.fill")
                }
            RockPaperScissors()
                .tabItem {
                    Label("Rock", systemImage: "eyes.inverse")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
