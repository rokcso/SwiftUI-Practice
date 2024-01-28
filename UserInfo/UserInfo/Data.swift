//
//  Data.swift
//  UserInfo
//
//  Created by rokcso on 2024/1/28.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

class UserData: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = false
    
    func fetchData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("无效的 URL")
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print("数据获取失败：\(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("没有数据返回")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            do {
                let users = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = users
                    self.isLoading = false
                }
            } catch {
                print("JSON 解析失败：\(error)")
            }
        }
        .resume()
    }
}
