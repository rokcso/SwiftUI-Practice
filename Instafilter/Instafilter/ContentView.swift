//
//  ContentView.swift
//  Instafilter
//
//  Created by rokcso on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.red
    
    var body: some View {
        Button("Hello, World!") {
            showingConfirmation = true
        }
        .frame(width: 300, height: 200)
        .background(backgroundColor)
        .font(.title.weight(.bold))
        .foregroundColor(.white)
        .confirmationDialog("Change background", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Yellow") { backgroundColor = .yellow}
            Button("Cannel", role: .cancel) {}
        } message: {
            Text("Select a new color.")
        }
    }
}

#Preview {
    ContentView()
}
