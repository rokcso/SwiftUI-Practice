//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by rokcso on 2024/1/28.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query() var users: [User]
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> {
            user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(users) {
            user in
            Text(user.name)
            
            Spacer()
            
            Text(String(user.jobs.count))
                .fontWeight(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

//#Preview {
//    UsersView()
//        .modelContainer(for: User.self)
//}
