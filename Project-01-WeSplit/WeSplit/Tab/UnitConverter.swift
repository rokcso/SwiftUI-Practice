//
//  UnitConverter.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/24.
//

import SwiftUI

struct UnitConverter: View {
    private let unitList: [String] = ["second", "minute", "hour", "day"]
    @State private var selectedFromUnit: String = "second"
    @State private var selectedToUnit: String = "minute"
    @State private var fromData: Double = 0
    @FocusState private var fromInputIsFocus: Bool
    var indexData: Double {
        switch selectedFromUnit {
        case "second":
            return fromData
        case "minute":
            return fromData * 60
        case "hour":
            return fromData * 60 * 60
        case "day":
            return fromData * 24 * 60 * 60
        default:
            return 0
        }
    }
    var toData: Double {
        switch selectedToUnit {
        case "second":
            return indexData
        case "minute":
            return indexData / 60
        case "hour":
            return indexData / 60 / 60
        case "day":
            return indexData / 60 / 60 / 24
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("From Info") {
                    TextField("Input From Data", value: $fromData, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($fromInputIsFocus)
                    
                    Picker("Select From Unit", selection: $selectedFromUnit) {
                        ForEach(unitList, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("To Info") {
                    Picker("Select To Unit", selection: $selectedToUnit) {
                        ForEach(unitList, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(toData)")
                }
            }
            
            .navigationTitle("Unit Converter")
            .toolbar {
                if fromInputIsFocus {
                    Button("Done") {
                        fromInputIsFocus.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    UnitConverter()
}
