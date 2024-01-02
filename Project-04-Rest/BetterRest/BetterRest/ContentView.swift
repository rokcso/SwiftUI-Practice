//
//  ContentView.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/2.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Float = 8.0
    @State private var wakeUpTime: Date = Date.now
    
    var body: some View {
        VStack {
            Stepper("Sleep \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            DatePicker("Wake up time", selection: $wakeUpTime, in: Date.now..., displayedComponents: .hourAndMinute)
//                .labelsHidden()
            
            Text(wakeUpTime, format: .dateTime.year().month().day().hour().minute())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
