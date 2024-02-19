//
//  iTourApp.swift
//  iTour
//
//  Created by niein on 2024/2/19.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self) // 为 Destination 对象创建 Storage container
        // 同时也会创建一个 Model context，这个 Model context 会自动跟踪 App 正在使用（活跃）的所有数据对象（并非所有数据对象）
    }
}
