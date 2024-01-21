//
//  addHabit.swift
//  Habit
//
//  Created by rokcso on 2024/1/21.
//

import SwiftUI

struct addHabit: View {
    @State private var title: String = ""
    @State private var type: String = "Life"
    private let types: [String] = ["Life", "Work", "Sport"]
    @State private var description: String = ""
    @State private var targetNumString: String = ""
    @State private var targetNum: Int = 0
    
    var habitList: HabitList
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit title", text: $title)
                
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
    //                .pickerStyle(.segmented)
                    
                    HStack {
                        TextField("Target times", text: $targetNumString)
                            .keyboardType(.numberPad)
                            .onChange(of: targetNumString) {
//                                newValue in
                                targetNum = Int(targetNumString) ?? 0
                            }
                        
                        Stepper(value: $targetNum, in: 0...Int.max) {
//                            Text("Target times")
                        }
                        .onChange(of: targetNum) {
//                            newValue in
                            targetNumString = String(targetNum)
                        }
                    }
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                }
            }
            
            .navigationTitle("Add habit")
            .toolbar {
                Button("Save") {
                    let habitItem = HabitItem(title: title, type: type, description: description, targetNum: targetNum)
                    habitList.items.append(habitItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    addHabit(habitList: HabitList())
}
