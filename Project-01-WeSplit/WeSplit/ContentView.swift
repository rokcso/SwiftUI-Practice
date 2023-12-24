//
//  ContentView.swift
//  WeSplit
//
//  Created by rokcso on 2023/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TipCalculator()
                .tabItem {
                    Label("Tip", systemImage: "list.dash")
                }
            UnitConverter()
                .tabItem {
                    Label("Unit", systemImage: "square.and.pencil")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
