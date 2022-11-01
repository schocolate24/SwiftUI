//
//  ContentView.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/02.
//

import Charts
import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    let week: String
    let value: Double
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var finance: FetchedResults<Finance>
    @State private var avarageSpentOfThePreviousMonth = 0
    @State private var showMenu: Bool = false
    var spent = AddSpent()
    
    let items: [Item] = [
        Item(week: "Monday", value: 120),
        Item(week: "Tuesday", value: 40),
        Item(week: "Wednesday", value: 78),
        Item(week: "Thursday", value: 59),
        Item(week: "Friday", value: 160),
        Item(week: "Saturday", value: 110),
        Item(week: "Sunday", value: 94)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.55, green: 0.4, blue: 0.7).ignoresSafeArea()
                Color.indigo
                VStack {
                    ScrollView {
                        Chart(items) { item in
                            LineMark(x: .value("Department", item.week),
                                     y: .value("Profit", item.value)
                            )
                            .foregroundStyle(Color.pink.gradient)
                        }
                        .frame(height: 300)
                        .padding()
                    }
//                    Group {
//                        Text("The average daily spent of the last month")
//                        Text("$0")
//                    }.foregroundColor(.black)
                    
                    
                    VStack {
                        Text("Today's total spent: \(spent.total())")
                        
                        HStack {
                            NavigationLink {
                                AddSpent()
                            } label: {
                                Text("Today's Spent")
                            }
                            .frame(width: 130, height: 100)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                            .background(.blue)
                            .cornerRadius(10)
                            
                            NavigationLink {
                                PastSpent()
                            } label: {
                                Text("Past Spent")
                            }
                            .frame(width: 130, height: 100)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                            .background(.yellow)
                            .cornerRadius(10)
                        }
                        Button("Income?") {
                            // additional income view
                        }
                        .frame(width: 270, height: 70)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 24))
                        .background(.pink)
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .navigationTitle("Finance Managing")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        self.showMenu.toggle()
                    } label: {
                        if showMenu {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.title)
                        } else {
                            Image(systemName: "text.justify")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                }
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        SideMenu()
                            .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.4), value: showMenu)
                    }
                }
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
