//
//  HiraganaView.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/08.
//

import SwiftUI

struct KatakanaView: View {
    let katakana: [Japanese] = Bundle.main.decode("Katakana.json")
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
                        HiraganaView()
                    } else {
                        Button(Katakana == Hiragana ? "ひらがな" : "カタカナ") {
                            switchingView.toggle()
                        }
                        .foregroundColor(.cyan)
                        .padding(.leading,280)
                        
                        Text("Katakana(カタカナ)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding([.bottom,.top],10)

                        LazyVGrid(columns: layout) {
                            ForEach(katakana, id: \.id) { katakana in
                                NavigationLink {
                                    KatakanaDetailView(JapaneseID:katakana.id,
                                               letter:katakana.letter,
                                               image:katakana.image,
                                               example:katakana.example,
                                               voice1:katakana.voice1,
                                               voice2:katakana.voice2)
                                } label: {
                                    Text(katakana.letter)
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
struct KatakanaView_Previews: PreviewProvider {
    static var previews: some View {
        KatakanaView()
    }
}
