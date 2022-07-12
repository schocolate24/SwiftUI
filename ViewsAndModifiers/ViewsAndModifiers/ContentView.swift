//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 中木翔子 on 2022/05/14.
//

//the order of modifiers matters to reflect what you have in your mind correctly

import SwiftUI


struct ContentView: View {
    
    @State private var choice = ["✊","✌️","✋"].shuffled()
    @State private var appschoice = "✋"
    let display = ["✊","✌️","✋"]
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var counter = 0
    


    
    var winOrLose: String {
        if shouldWin {
            return "Win it !"
        } else {
            return "Lose it !"
        }
    }
   
        
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.cyan, Color(red: 0.6, green: 0.4, blue: 0.6)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Text("Rock,Scissors,Paper!")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(.thinMaterial)
                    Text(winOrLose)
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.thinMaterial)
                        .padding()
                    Text(appschoice)
                        .font(.system(size: 120))
                    
                    HStack{
                        Button("✊"){}
                        Button("✌️"){}
                        Button("✋"){}
                        
                    }   .padding()
                        .font(.system(size: 70))
                    
                    Spacer()
                    
                    VStack {
                        Text("Score: \(score)")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Text("Count: \(counter) / 5")
                            .font(.title)
                            .foregroundColor(.cyan)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

