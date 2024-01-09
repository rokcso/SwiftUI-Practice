//
//  ContentView.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/2.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            CoffeeP()
                .tabItem {
                    Label("Coffee", systemImage: "cup.and.saucer.fill")
                }
            Word()
                .tabItem {
                    Label("Word", systemImage: "note.text")
                }
            Challenge()
                .tabItem {
                    Label("Challenge", systemImage: "figure.walk.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
