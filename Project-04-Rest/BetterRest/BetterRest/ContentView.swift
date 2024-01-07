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
            Animation()
                .tabItem {
                    Label("Animation", systemImage: "livephoto.badge.automatic")
                }
        }
    }
}

#Preview {
    ContentView()
}
