//
//  Test02.swift
//  Navigation
//
//  Created by rokcso on 2024/1/15.
//

import SwiftUI

struct Test02: View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("HELLO")
            
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Test02()
}
