//
//  Challenge.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/9.
//

import SwiftUI

struct Challenge: View {
    @State private var numA: Int = 8
    @State private var numB: Int = 8
    @State private var questionTimes: Int = 3
    @State private var numAofQuestion: Int = 1
    @State private var numBofQuestion: Int = 1
    @State private var answerIntput: String = ""
    @State private var answerNum: Int = 0
    @State private var answerError: Bool = false
    @State private var resultText: String = "???"
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("multiplication tables"), footer: Text("The tables will from 1x1 to \(numA + 1)x\(numB + 1)")) {
                    Picker("numA", selection: $numA) {
                        ForEach(1..<13) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("numA", selection: $numB) {
                        ForEach(1..<13) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Number of questions"), footer: Text("Times: \(questionTimes)")) {
                    Stepper("I need \(questionTimes) questions", value: $questionTimes, in: 1...10, step: 1)
                }
                
                Section("Question") {
                    Button("New Question", action: newQuestion)
                    Text("\(numAofQuestion) x \(numBofQuestion) = ?")
                }
                
                Section("Answer") {
                    ZStack {
                        TextField("Input answer number", text: $answerIntput)
                            .keyboardType(.decimalPad)
                            .onSubmit {
                                answerNum = Int(answerIntput) ?? 0
                                isInputActive = false
                            }
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        answerNum = Int(answerIntput) ?? 0
                                        isInputActive = false
                                    }
                                }
                            }
                    }
                    .onTapGesture {
                        isInputActive = false
                        answerNum = Int(answerIntput) ?? 0
                    }
                        
                    Button("Check answer: \(answerNum)") {
                        checkAnswer()
                    }
                    Text(resultText)
                }
            }
            
            .navigationTitle("axb=?")
            .toolbar(content: {
                Button(action: {
                    restart()
                }, label: {
                    Text("Restart")
                })
            })
            .alert(isPresented: $answerError, content: {
                Alert(
                    title: Text("Answer is error"),
                    message: Text("Are you a fool? I can't even calculate such a simple multiplication."),
                    dismissButton: .default(Text("Fuck"))
                )
            })
        }
        
    }
    
    func newQuestion() {
        numAofQuestion = Int.random(in: 1...(numA + 1))
        numBofQuestion = Int.random(in: 1...(numB + 1))
        answerIntput = ""
    }
    
    func checkAnswer() {
        if questionTimes > 0 {
            questionTimes -= 1
            if answerNum == numAofQuestion * numBofQuestion {
                resultText = "You're right."
            } else {
                resultText = "Fuck!"
                answerError = true
            }
            newQuestion()
        } else {
            resultText = "Times over."
        }
    }
    
    func restart() {
        numA = 8
        numB = 8
        questionTimes = 3
        answerIntput = ""
    }
    
}

#Preview {
    Challenge()
}
