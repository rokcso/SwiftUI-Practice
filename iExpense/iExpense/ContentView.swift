//
//  ContentView.swift
//  iExpense
//
//  Created by rokcso on 2024/1/10.
//

import SwiftUI
import Observation

@Observable
class User {
    var firstName = "warig"
    var lastName = "hu"
}

struct ContentView: View {
    @State private var user = User()
    @State private var showSecond = false
    @State private var nums = [Int]()
    @State private var currentNum = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Show second") {
                    showSecond.toggle()
                }
                .sheet(isPresented: $showSecond, content: {
                    Second(name: "waringhu")
                })
                
                
                
                List {
                    ForEach(nums, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: { indexSet in
                        removeRow(as: indexSet)
                    })
                }
                
                Button("Add row") {
                    nums.append(currentNum)
                    currentNum += 1
                }
            }
            .navigationTitle("Test")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRow(as offsets: IndexSet) {
        nums.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
