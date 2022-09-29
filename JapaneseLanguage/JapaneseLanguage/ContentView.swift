//
//  ContentView.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/08.
//

import SwiftUI

struct Modification: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 250, height: 50)
    }
}
extension View {
    func modification() -> some View {
        modifier(Modification())
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea()
                VStack {
                    Spacer(minLength: 250)
                    
                    Text("🎌 Chose the content 🎌")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                    
                    NavigationLink {
                        HiraganaView()
                    } label: {
                        Group {
                            Text("あ  Letters  ア")
                        }
                    }
                    .modification()
                    .background(.cyan)
                    .cornerRadius(10)
                    .padding(20)
                    
                    NavigationLink {
                        HiraganaQuiz()
                    } label: {
                        Text("Take Quiz")
                    }
                    .modification()
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(20)
                    
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle("")
            .preferredColorScheme(.dark)
            }
      }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
