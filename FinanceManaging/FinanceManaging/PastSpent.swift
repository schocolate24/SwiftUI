//
//  PastSpent.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import SwiftUI

struct PastSpent: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var finances: FetchedResults<Finance>
    
    @State var totalAmount = [Double]()
    @State var spending = 0.0
    @State var sum = 0.0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(finances) { finance in
                    HStack {
                        Text(finance.name ?? "")
                        Text("\(finance.spending, format: .currency(code: "USD"))")
                            .padding(.trailing)
                        Text("\(finance.date ?? Date.now)")
                    }
                }
                .onDelete(perform: deleteSpending)
            }
            .navigationTitle("Past Spendings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
  
    func deleteSpending(at offsets: IndexSet) {
        for offset in offsets {
            let finance = finances[offset]
            moc.delete(finance)
        }
        try? moc.save()
    }
    
    func total(amount _ : Double) -> Double {
        totalAmount.append(spending)
        sum = totalAmount.reduce(0, +)
        let am = (sum * 100).rounded() / 100
        
        return am
    }
}

struct PastSpent_Previews: PreviewProvider {
    static var previews: some View {
        PastSpent()
    }
}
