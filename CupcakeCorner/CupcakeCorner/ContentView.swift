//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by rokcso on 2024/1/23.
//

import SwiftUI

@Observable
class User: Codable {
    var name = "Taylor"
}

struct ContentView: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ContentView()
}
