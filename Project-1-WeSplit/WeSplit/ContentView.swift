//
//  ContentView.swift
//  WeSplit
//
//  Created by 张洋 on 2021/9/7.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages = [5, 10, 20, 30, 0]
    
    @State var amount: Double = 0
    @State var numberOfPeople = 0
    @State var tipPercent = 0
    @FocusState var inputFocused: Bool
    
    var totalAmount: Double{
        return (amount * (1 + Double(tipPercent) / 100))
    }
    
    var totalPerPerson: Double{
        return  totalAmount / Double(numberOfPeople + 2)
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($inputFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 99) {
                            Text("\($0) people")
                        }
                    }
                }
                
                //为section添加header比直接添加Text要好
                Section("How much tip do you want to leave?") {
                    Picker("Tip percent", selection: $tipPercent){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.wheel)
//                    Picker("Tip percent", selection: $tipPercent) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }.pickerStyle(.segmented)  //较短的Picker可以考虑使用SegmentPickerStyle来获得更好的显示效果
                }
                
                Section("Amount per person"){
                    //                    Text("$\(totalPerPerson, specifier: "%.2f")")
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Amount") {
                    //                    Text("$\(totalAmount, specifier: "%.2f")").foregroundColor(tipPercent == 0 ? .red : .blue)
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercent == 0 ? .red : .blue)
                }
            }.navigationTitle("WeSplit")
                .toolbar(content: {
                    if inputFocused {
                        Button("Done"){
                            inputFocused = false
                        }
                    }
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
