//
//  FormCheck.swift
//  CupcakeCorner
//
//  Created by rokcso on 2024/1/23.
//

import SwiftUI

struct FormCheck: View {
    @State private var username = ""
    @State private var email = ""
    
    var formDisable: Bool {
        return username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Submit") {
                    print("Submit \(username) and \(email)")
                }
            }
            .disabled(formDisable)
        }
    }
}

#Preview {
    FormCheck()
}
