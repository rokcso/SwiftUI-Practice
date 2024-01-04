//
//  Word.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/4.
//

import SwiftUI

struct Word: View {
    var body: some View {
        VStack{
            
            
            List {
                Section("dfsf") {
                    Text("asssss")
                    Text("fgfdgd")
                    Text("gfdgdf")
                }
                Section("dfdg") {
                    ForEach(0..<5) {
                        Text("\($0) dsfjsl")
                    }
                    
                    Text("gdfjflgjsdljglkd")
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    Word()
}
