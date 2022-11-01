//
//  SideMenu.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/09.
//

import SwiftUI

struct SideMenu: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .foregroundColor(.white)
            
            Divider()
                .frame(width: 190, height: 2)
                .background(.white)
                .padding(.horizontal, 10)
            
            Spacer()
        }
        .padding(32)
        .background(.purple)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
