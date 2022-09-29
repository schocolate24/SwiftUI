//
//  SplashView.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/14.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(colors: [.blue, .pink], startPoint: .bottom, endPoint: .top)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 150, height: 100)
                            .cornerRadius(5)
                        
                        Circle()
                            .fill(.red)
                            .frame(width: 70, height: 70)
                    }
                    Group {
                        Text("Japanese")
                        Text("for")
                        Text("Beginners")
                    }
                         .font(Font.custom("Baskerville-Bold", size: 40))
                         .foregroundColor(.white)
                 }
                 .onAppear {
                     withAnimation(.easeIn(duration: 2.0)) {
                         
                     }
                 }
                 .onAppear {
                     DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                         withAnimation{
                             self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
