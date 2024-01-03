//
//  ContentView.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/2.
//

import CoreML
import SwiftUI


struct ContentView: View {
    @State private var sleepAmount: Double = 8.0 {
        didSet {
            calculateBedtime()
        }
    }
    @State private var wakeUpTime: Date = defaultWakeTime {
        didSet {
            calculateBedtime()
        }
    }
    @State private var coffeeAmount: Int = 1
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("Your ideal bedtime is...") {
                    HStack {
                        Spacer()
                        Text(alertMsg)
                            .font(.title.weight(.bold))
                        Spacer()
                    }
                }
                
                Section("When do you want to wake up?") {
                    VStack(alignment: .leading, spacing: 10) {
                        DatePicker("Wake up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        
                        HStack {
                            Text("Tips: wake up at tomorrow")
                            Text(wakeUpTime, format: .dateTime.hour().minute())
                        }
                    }
                }
                Section("Desired amount of sleep") {
                    VStack(alignment: .leading, spacing: 10) {
                        Stepper("Sleep \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }
                
                Section("Daily coffee intake") {
                    VStack(alignment: .leading, spacing: 10) {
                        Stepper(coffeeAmount <= 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cups" , value: $coffeeAmount, in: 0...99, step: 1)
                    }
                }
                
                Section("Dailt coffee intake V2") {
                    Picker(coffeeAmount <= 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                        ForEach(0..<100) {
                            Text("\($0) cup")
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
//            .alert(alertTitle, isPresented: $showAlert) {
//                Button("OK") {}
//            } message: {
//                Text(alertMsg)
//            }
            
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMsg = sleepTime.formatted(date: .omitted, time: .shortened)
            showAlert = true
        } catch {
            alertTitle = "Error"
            alertMsg = "Sorry, there was a problem calculating your bedtime."
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
