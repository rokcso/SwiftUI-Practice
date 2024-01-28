//
//  ContentView.swift
//  UserInfo
//
//  Created by rokcso on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        NavigationStack {
            Group {
                if userData.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(userData.users) {
                        user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            VStack {
                                Text(user.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("User list")
            .onAppear {
                if userData.users.isEmpty {
                    userData.fetchData()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
