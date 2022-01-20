//
//  ContentView.swift
//  WeSplit
//
//  Created by 张洋 on 2021/9/7.
//

import SwiftUI

struct ContentView: View {
    @State var amount = ""
    @State var numberOfPeople = 2
    @State var tipPercentageIndex = 2
    @State var number = ""
    let tipPercentages = [5, 10, 20, 30, 0]
    var totalAmount: Double{
        let realAmount = Double(amount) ?? 0
        return (realAmount * (1 + Double(tipPercentages[tipPercentageIndex]) / 100))
    }
    
    var totalPerPerson: Double{
        return  totalAmount / Double(numberOfPeople + 2)
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 99) {
                            Text("\($0) people")
                        }
                    }
                    TextField("Number of people", text: $number)
                        .keyboardType(.numberPad)
                }
                
                //为section添加header比直接添加Text要好
                Section(header: Text("How much tip do you want to leave? - %")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) { index in
                            Text("\(self.tipPercentages[index])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())  //较短的Picker可以考虑使用SegmentPickerStyle来获得更好的显示效果
                }
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Total Amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
