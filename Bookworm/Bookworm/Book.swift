//
//  Book.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/27.
//

import Foundation
import SwiftData

@Model
class Book {
    var id: UUID
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    init(id: UUID, title: String, author: String, genre: String, review: String, rating: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
