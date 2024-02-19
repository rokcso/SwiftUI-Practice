//
//  Sight.swift
//  iTour
//
//  Created by niein on 2024/2/19.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    @Attribute(.unique) var flag: String // 使用 @Attribute(.unique) 可以自动限制 flag 唯一，但是 CloudKit 不支持该特性
    
    init(name: String = "", flag: String = "") {
        self.name = name
        self.flag = flag
    }
}
