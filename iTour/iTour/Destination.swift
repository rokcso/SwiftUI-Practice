//
//  Destination.swift
//  iTour
//
//  Created by niein on 2024/2/19.
//

import Foundation
import SwiftData

@Model // 为 Destination 启用 SwiftData 来做数据库管理
class Destination { // 这就是一个 SwiftData 数据模型对象，所有 SwiftData 模型对象都自动符合 Identifiable 协议
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
