//
//  HiraganaView.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/08.
//

import SwiftUI

struct HiraganaView: View {
    let hiragana: [Japanese] = Bundle.main.decode("Hiragana.json")
    let layout = [GridItem(.adaptive(minimum: 60, maximum: 80))]
    @State private var switchingView = false
    @State private var Katakana = ""
    @State private var Hiragana = ""
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                Group {
                    if switchingView {
                        KatakanaView()
                    } else {
                        Button(Hiragana == Katakana ? "カタカナ" : "ひらがな") {
                            switchingView.toggle()
                        }
                        .foregroundColor(.cyan)
                        .padding(.leading,280)
                        
                        Text("Hiragana(ひらがな)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding([.bottom,.top],10)
                        
                        
                        LazyVGrid(columns: layout) {
                            ForEach(hiragana, id: \.id) { hiragana in
                                NavigationLink {
                                    HiraganaDetailView(JapaneseID:hiragana.id,
                                               letter:hiragana.letter,
                                               image:hiragana.image,
                                               example:hiragana.example,
                                               voice1:hiragana.voice1,
                                               voice2:hiragana.voice2)
                                        
                                } label: {
                                    Text(hiragana.letter)
                                        .fontWeight(.heavy)
                                        .font(.system(size: 25))
                                }
                            }
                            .frame(width: 60, height: 60)
                            .background(.white)
                            .opacity(0.7)
                            .cornerRadius(10)
                            .padding()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                .foregroundColor(.black)
                .preferredColorScheme(.dark)
            }
        }
    }
}

struct HiraganaView_Previews: PreviewProvider {
    static var previews: some View {
        HiraganaView()
    }
}
