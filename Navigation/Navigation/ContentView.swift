//
//  ContentView.swift
//  Navigation
//
//  Created by rokcso on 2024/1/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100)
            {
                Text("Row \($0)")
            }
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Tap") {
                        //
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Tap111") {
                        //
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
