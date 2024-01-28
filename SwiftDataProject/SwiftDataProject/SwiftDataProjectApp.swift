//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by rokcso on 2024/1/27.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
