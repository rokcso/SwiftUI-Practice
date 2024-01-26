//
//  BookwormApp.swift
//  Bookworm
//
//  Created by rokcso on 2024/1/26.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
