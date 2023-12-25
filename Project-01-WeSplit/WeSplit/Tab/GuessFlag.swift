//
//  GuessFlag.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/25.
//

import SwiftUI

struct GuessFlag: View {
    @State private var showingAlert: Bool = false
    
    var body: some View {
        
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("AAAAA")
        }

    }
}

#Preview {
    GuessFlag()
}
