//
//  Second.swift
//  iExpense
//
//  Created by rokcso on 2024/1/10.
//

import SwiftUI


struct Users: Codable {
    let firstA: String
    let firstB: String
}

struct Second: View {
    let name: String
    @Environment(\.dismiss) var dismiss
    
    @State private var tapCnt = UserDefaults.standard.integer(forKey: "tapCnt")
    
    @AppStorage("selectedNum") private var selectedNumber = 0
    
    @State private var userA = Users(firstA: "AA", firstB: "BB")
    
    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button("Dismiss") {
                dismiss()
            }
            
            Button("Tap count: \(tapCnt)") {
                tapCnt += 1
                UserDefaults.standard.set(tapCnt, forKey: "tapCnt")
            }
            
            Stepper("Selected number: \(selectedNumber)", value: $selectedNumber, in: 1...10, step: 1)
                .padding()
            
            Button("Save user") {
                let encoder = JSONEncoder()
                
                if let userData = try? encoder.encode(userA) {
                    UserDefaults.standard.set(userData, forKey: "userData")
                }
            }
        }
    }
}

#Preview {
    Second(name: "aaa")
}
