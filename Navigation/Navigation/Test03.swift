//
//  Test03.swift
//  Navigation
//
//  Created by rokcso on 2024/1/20.
//

import SwiftUI

struct Test03: View {
    
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $path) {
            Detail(num: 0, path: $path)
                .navigationDestination(for: Int.self) {
                    i in
                    Detail(num: i, path: $path)
                }
        }
    }
}

struct Detail: View {
    var num: Int
    @Binding var path: [Int]
    
    var body: some View {
        NavigationLink("Go to Random Num", value: Int.random(in: 1...1000))
            .navigationTitle("Num: \(num)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

#Preview {
    Test03()
}
