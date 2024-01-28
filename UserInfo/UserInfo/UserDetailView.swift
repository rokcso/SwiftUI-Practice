//
//  UserDetailView.swift
//  UserInfo
//
//  Created by rokcso on 2024/1/28.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        List {
            Text("Name: \(user.name)")
            Text("Age: \(user.age)")
            Text("Company: \(user.company)")
            Text("Email: \(user.email)")
            Text("Address: \(user.address)")
            Text("About: \(user.about)")
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) {
                    friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle("\(user.name)")
    }
}
//
//#Preview {
//    UserDetailView()
//}
