//
//  ContentView.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @FocusState private var amountIsFocused: Bool
    @State private var numberOfPeople: Int = 0
    let tipPercentages: [Int] = [0, 5, 10, 15, 20, 25, 30]
    @State private var tipPercentage: Int = 10
    var totalPerPerson: Double {
        return (Double(checkAmount) * Double((Double(tipPercentage) / 100) + 1)) / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people.", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) peoples")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Per person amount") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
