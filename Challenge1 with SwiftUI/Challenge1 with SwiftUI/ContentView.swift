//
//  ContentView.swift
//  Challenge1 with SwiftUI
//
//  Created by 中木翔子 on 2022/05/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    @State private var outPutValue = ""
    
    @State private var inputUnitValue = 2
    let inputUnits = ["milliliter", "liter", "gallon", "cup"]
    
    @State private var outputUnitValue = 2
    let outputUnits = ["milliliter", "liter", "gallon", "cup"]
    
    var inputUnitAfterConversionToOutput: String {
        var output = ""
        var input = Measurement(value: 0, unit: UnitVolume.liters)
    
    
        switch inputUnits[inputUnitValue] {
        case "milliliter":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitVolume.milliliters)
        case "liter":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitVolume.liters)
        case "gallon":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitVolume.gallons)
        case "cup":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitVolume.cups)
            
        default:
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitVolume.milliliters)
        }
        
        switch outputUnits[outputUnitValue] {
        case "milliliter":
            output = String(describing: input.converted(to: UnitVolume.milliliters))
        case "liter":
            output = String(describing: input.converted(to: UnitVolume.liters))
        case "gallon":
            output = String(describing: input.converted(to: UnitVolume.gallons))
        case "cup":
            output = String(describing: input.converted(to: UnitVolume.cups))
            
        default:
            output = String(describing: input.converted(to: UnitVolume.milliliters))
        }
        return output
    }
    @FocusState private var amountIsFocused: Bool
   
    
    var body: some View {
        
        NavigationView {
            
           Form {
                Section{
                    Picker("Select an input unit", selection: $inputUnitValue) {
                        ForEach(0..<inputUnits.count) {
                            Text("\(inputUnits[$0])")
                        }
                    }.pickerStyle(.segmented)
                }
                Section {
                    Picker("Select an output unit", selection: $outputUnitValue) {
                        ForEach(0..<outputUnits.count) {
                            Text("\(outputUnits[$0])")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    TextField("Amount",text: $inputValue)
                } header: {
                    Text("Input the amount")
                }
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)

                Section {
                    Text(inputUnitAfterConversionToOutput)
                        
                } header: {
                    Text("Output")
                }
          }
            .navigationTitle("Volume conversions")
                
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
