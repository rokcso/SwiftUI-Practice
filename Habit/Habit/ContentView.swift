//
//  ContentView.swift
//  Habit
//
//  Created by rokcso on 2024/1/21.
//

import SwiftUI

struct HabitItem: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let type: String
    let description: String
    var markedNum: Int = 0
    let targetNum: Int
    var progress: Double {
        return targetNum > 0 ? Double(markedNum) / Double(targetNum) : 0.0
    }
}

@Observable
class HabitList {
    var items = [HabitItem]() {
        didSet {
            saveData()
        }
    }
    
    init() {
        loadData()
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    func loadData() {
        if let itemsData = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: itemsData) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @State private var habitList = HabitList()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(habitList.items) {
                        item in
                        VStack {
                            HStack {
                                Text(item.title)
                                    .font(.title3.weight(.bold))
                                Spacer()
                                Text("\(item.markedNum) marks")
                            }
                            HStack {
                                Text("#\(item.type)")
                                    .font(.subheadline.weight(.light))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            ProgressView(value: item.progress, total: 1.0)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        habitList.items.remove(atOffsets: indexSet)
                    })
                }
            }
            
            .navigationTitle("Habit")
            .toolbar {
                Button("Add Habit") {
                    showAddHabit = true
                }
            }
        }
        .sheet(isPresented: $showAddHabit, content: {
            addHabit(habitList: habitList)
        })
    }
}

#Preview {
    ContentView()
}
