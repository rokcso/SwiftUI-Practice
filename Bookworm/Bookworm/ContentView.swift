//
//  ContentView.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/27.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showAddBookView = false
    
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
            
            .navigationTitle("Book worm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        showAddBookView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
            }
        }
    }
}

#Preview {
    ContentView()
}
