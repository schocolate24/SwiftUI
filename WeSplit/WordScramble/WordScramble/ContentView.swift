//
//  ContentView.swift
//  WordScramble
//
//  Created by 中木翔子 on 2022/05/28.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var counter = 0
    @State private var letterCounter = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationView {
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    Text("Word count: \(counter)")
                        .fontWeight(.semibold)
                }
                Section {
                    Text("Total number of letters: \(letterCounter)")
                        .fontWeight(.semibold)
                }
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Start it over") {
                    startGame()
                    usedWords = [String]()
                    newWord = ""
                    counter = 0
                    letterCounter = 0
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK" , role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
           
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isImpossible(word: answer) else {
            wordError(title: "Too short", message: "Think of words that are more than three letters")
            return
        }
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)' !")
            return
        }
        
        guard theRootWord(word: answer) else {
            wordError(title: "Not available", message: "You can't just copy the start word")
            return
        }
        
      
        
        withAnimation {
        usedWords.insert(answer, at: 0)
        }
        newWord = ""
        
        counter += 1
        letterCounter += answer.count
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
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
    
    func isImpossible(word: String) -> Bool {
        if word.count < 3 {
            return false
        } else {
            return true
        }
    }
    
    func theRootWord(word: String) -> Bool {
        if word == rootWord {
            return false
        } else {
            return true
        }
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


