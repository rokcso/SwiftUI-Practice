//
//  Test02.swift
//  Navigation
//
//  Created by rokcso on 2024/1/15.
//

import SwiftUI

struct Test02: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }

                ForEach(0..<5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
            .toolbar {
                Button("Push 335") {
                    path.append(334)
                }
                
                Button("Push dsfg") {
                    path.append("djfas")
                }
            }
        }
    }
}

#Preview {
    Test02()
}
