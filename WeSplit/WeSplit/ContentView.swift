//
//  ContentView.swift
//  WeSplit
//
//  Created by 中木翔子 on 2022/05/04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
   
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var useRedBackground: Bool {
        if tipPercentage == 0 {
            return true
        }
        return false
    }
        
    var currency = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView{
          
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    
                    Picker("number of people", selection: $numberOfPeople) {
                        ForEach(2..<101){
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson * Double(numberOfPeople + 2),format: currency)
                        .foregroundColor(useRedBackground ? .red : .black)
                } header: {
                    Text("total")
                }
                Section {
                    Text(totalPerPerson,format: currency)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("We split")
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
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
}
