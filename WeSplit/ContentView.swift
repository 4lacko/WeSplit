//
//  ContentView.swift
//  WeSplit
//
//  Created by Ayo Moreira on 5/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false;
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocued: Bool
    
    let tipPercentages = 0..<101
    
    var totalAmount: Double {
        checkAmount + (checkAmount / 100 * Double(tipPercentage))
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    let currencyLocale = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyLocale)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocued)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: currencyLocale)
                        .foregroundColor(!useRedText ? .red : .black)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyLocale)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocued = false
                    }
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
