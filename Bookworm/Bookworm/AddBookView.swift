//
//  AddBookView.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/27.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var id: UUID = UUID()
    @State var title: String = ""
    @State var author: String = ""
    @State var genre: String = ""
    @State var review: String = ""
    @State var rating: Int = 0
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Autor of book", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
                    
                    RatingView(rating: $rating, label: "Rating")
                    
                }
                
                Section {
                    Button("Save") {
                        let book = Book(id: UUID(), title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        modelContext.insert(book)
                        
                        dismiss()
                    }
                }
            }
            
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView(id: UUID(), title: "测试书籍", author: "rokcso", genre: "Horror", review: "非常不错的一本书，我看了不下 100 遍", rating: 5)
}
