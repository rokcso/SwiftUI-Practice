//
//  DetailView.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/27.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        
        .alert("Delete book", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(id: UUID(), title: "就是测试一下", author: "rokcso", genre: "Horror", review: "简单的对这本书进行一些评价，这本书是相当的不错，我也就读了 100 遍吧！", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create previre: \(error.localizedDescription)")
    }
}
