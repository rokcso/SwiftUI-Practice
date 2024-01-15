//
//  Test01.swift
//  Navigation
//
//  Created by rokcso on 2024/1/15.
//

import SwiftUI

struct Test01: View {
    var body: some View {
        NavigationStack {
            Text("Hello")
                .toolbar {
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button("Agree") {
                            //
                        }
                        
                        Button("Ag32ree") {
                            //
                        }
                    }
                }
        }
    }
}

#Preview {
    Test01()
}
