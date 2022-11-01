//
//  AView.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/10.
//

import SwiftUI

struct HiraganaDetailView: View {
    @StateObject var soundplayer = Audio()
    
    let hiragana: [Japanese] = Bundle.main.decode("Hiragana.json")
 
    @State var JapaneseID: Japanese.ID
    @State var letter: String
    @State var image: String
    @State var example: String
    @State var voice1: String
    @State var voice2: String
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            VStack {
                Text(hiragana[JapaneseID].letter)
                    .foregroundColor(.white)
                    .font(.system(size: 150))
                
                Button {
                    soundplayer.playSounds(file: hiragana[JapaneseID].voice1)
                } label: {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 25))
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(.white)
                .cornerRadius(15)
                .padding(.leading, 250)
                .padding(.bottom, 160)
                .padding(.top, -120)
                
                Spacer()
                
                Image(hiragana[JapaneseID].image)
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding(.top, -160)
                    .padding(.bottom,30)
                                               
                HStack {
                    Text(hiragana[JapaneseID].example)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    
                    Button {
                        soundplayer.playSounds(file: hiragana[JapaneseID].voice2)
                    } label: {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 25))
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.leading)
                }
                Spacer()
                Spacer()
                
                HStack {
                    if self.JapaneseID == 0 {
                        
                    } else {
                        Button(action: {
                            self.JapaneseID -= 1
                        }) {
                            Image(systemName: "chevron.left")
                                .padding(.leading)
                            Text("Previous")
                        }
                    }
                        Spacer(minLength: 150)
                    if self.JapaneseID == 45 {
                        
                    } else {
                        Button(action: {
                            self.JapaneseID += 1
                        }) {
                            Text("Next")
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                        }
                    }
                }
                .padding(.bottom,30)
            }
        }
    }
}
