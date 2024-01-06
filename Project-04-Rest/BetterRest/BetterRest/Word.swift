//
//  Word.swift
//  BetterRest
//
//  Created by rokcso on 2024/1/4.
//

import SwiftUI

struct Word: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section("Score") {
                    Text("\(score)")
                }
                
                Section() {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section() {
                    ForEach(usedWords, id: \.self) {
                        word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMsg),
                    dismissButton: .default(Text("OK"))
                )
            })
            
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart", action: startGame)
            }
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: {
                startGame()
            })
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count >= 3 else {
            showAlert(title: "Word count error", msg: "A word with at least 3 letters is required!")
            return
        }
        guard isOriginal(word: answer) else {
            showAlert(title: "Word used already", msg: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            showAlert(title: "Word not possible", msg: "You can't spell that word from '\(rootWord)'!")
            score -= 1
            return
        }
        guard isReal(word: answer) else {
            showAlert(title: "Word not recognized", msg: "You can't just make them up, you know!")
            score -= 1
            return
        }
        guard answer != rootWord else {
            showAlert(title: "Can't Rootword", msg: "You can't input \(rootWord)")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += 1
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                newWord = ""
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func showAlert(title: String, msg: String) {
        alertTitle = title
        alertMsg = msg
        showAlert = true
    }
}

#Preview {
    Word()
}
