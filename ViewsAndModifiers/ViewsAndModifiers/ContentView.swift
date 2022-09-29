//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 中木翔子 on 2022/05/14.
//


import SwiftUI

struct DrawText: ViewModifier {
    let font = Font.system(size: 33, weight: .heavy, design: .default)
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

struct DrawHorizontalText: View {
    var text: String
    var textResult: String
    
    var body: some View {
        HStack {
            Text(text)
                .modifier(DrawText())
                .foregroundColor(.white)
                        
            Text(textResult)
                .modifier(DrawText())
                .foregroundColor(.pink)
        }
    }
}

struct DrawImageView: View {
    var imageName: String
    
    var body: some View {
        Text("\(imageName)")
            .padding()
            .padding()
            .background(Color.blue)
            .cornerRadius(25)
    }
}

struct ContentView: View {
    @State private var curentChoise = 0
    @State private var winOrLose = Bool.random()
    @State private var totalScore = 0
    @State private var showingScore = false
    @State private var randomComputerChoise = Int.random(in: 0...2)
    
    let possibleMoves = ["☄️","📄","✂️"]
        
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.cyan, Color(red: 0.6, green: 0.4, blue: 0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 100) {
                Text("Rock Paper Scissors!")
                    .modifier(DrawText())
                    .foregroundColor(.white)
                VStack(spacing: 50) {
                    DrawHorizontalText(text: "Your score is: ", textResult: "\(totalScore)")
                    DrawImageView(imageName: "\(possibleMoves[randomComputerChoise])")
                    DrawHorizontalText(text: "You must...", textResult: winOrLose ? "win" : "lose")
                    HStack {
                        ForEach(0..<possibleMoves.count) { number in
                            Button(action: {
                                self.checkTowin(selectedName:
                                    self.possibleMoves[number])
                            }) {
                                DrawImageView(imageName: "\(self.possibleMoves[number])")
                            }
                        }
                    }
                }
            }
        }.alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text("You win"), message: Text("Your score is \(self.totalScore)"), dismissButton: .default(Text("New Game")) {
                self.totalScore = 0
                self.winOrLose = Bool.random()
                self.randomComputerChoise = Int.random(in: 0...2)
            })
        }
    }
    
    func checkTowin(selectedName: String) {
        guard let index = possibleMoves.firstIndex(where: {return $0 == possibleMoves[randomComputerChoise]}) else {return}
        let prefixArray = possibleMoves.prefix(upTo: index)
        let suffixArray = possibleMoves.suffix(from: index)
        
        let wrappedArray = suffixArray + prefixArray
        
        guard let computedIndex = wrappedArray.firstIndex(where: {return $0 == possibleMoves[randomComputerChoise]}) else {return}
        guard let selectedIndex = wrappedArray.firstIndex(where: {return $0 == selectedName}) else {return}
        
        if winOrLose {
            totalScore += computedIndex + 1 == selectedIndex ? 1 : 0
        } else {
            totalScore += !(computedIndex + 1 == selectedIndex) ? 1 : 0
        }
        
        self.winOrLose = Bool.random()
        self.randomComputerChoise = Int.random(in: 0...2)
        
        runNewGame()
    }
    
    func runNewGame() {
        if self.totalScore == 10 {
            self.showingScore = true
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


