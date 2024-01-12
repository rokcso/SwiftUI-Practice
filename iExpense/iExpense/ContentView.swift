//
//  ContentView.swift
//  iExpense
//
//  Created by rokcso on 2024/1/10.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expense()
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !personalExpenses.isEmpty {
                    Section("Personal") {
                        ForEach(expenses.items.filter { $0.type == "Personal" }) {
                            item in
                            ExpenseRow(item: item, currencyCode: expenses.currencyCode)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                
                if !businessExpenses.isEmpty {
                    Section("Business") {
                        ForEach(expenses.items.filter { $0.type == "Business" }) {
                            item in
                            ExpenseRow(item: item, currencyCode: expenses.currencyCode)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
        
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


extension View {
    func style(for amount: Double) -> some View {
        modifier(AmountStyle(amount: amount))
    }
}


struct AmountStyle: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color(for: amount))
            .fontWeight(weight(for: amount))
    }
    
    private func color(for amount: Double) -> Color {
        switch amount {
        case 0..<10:
            return .green
        case 10..<100:
            return .orange
        default:
            return .red
        }
    }
    
    private func weight(for amount: Double) -> Font.Weight {
        switch amount {
        case 0..<10:
            return .light
        case 10..<100:
            return .regular
        default:
            return .bold
        }
    }
}



#Preview {
    ContentView()
}
