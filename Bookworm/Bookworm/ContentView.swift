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
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.title)
    ]) var books: [Book]
    
    @State private var showAddBookView = false
    
    var body: some View {
        NavigationStack {
//            Text("Count: \(books.count)")
            List {
                ForEach(books) {
                    book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingVIew(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    for offset in indexSet {
                        let book = books[offset]
                        modelContext.delete(book)
                    }
                })
            }
            .navigationDestination(for: Book.self) {
                book in
                DetailView(book: book)
            }
            
            .navigationTitle("Book worm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        showAddBookView.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
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
