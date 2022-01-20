//
//  ContentView.swift
//  D19Challenge
//
//  Created by 张洋 on 2021/9/28.
//

import SwiftUI

struct ContentView: View {
    @State var fromValue = ""
    
    let TIME_UNITS: [TimeUnit] = [
        TimeUnit("Seconds", 1),
        TimeUnit("Minutes", 60),
        TimeUnit("Hours", 60 * 60),
        TimeUnit("Days", 60 * 60 * 24)
    ]
    @State var fromUnitIndex: Int = 0
    @State var toUnitIndex: Int = 0
    
    var toValue: Double{
        ((Double(fromValue) ?? 0) * TIME_UNITS[fromUnitIndex].factor) / TIME_UNITS[toUnitIndex].factor
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("From")) {
                    TextField("Value", text: $fromValue).keyboardType(.decimalPad)
                    Picker("TimeUnits", selection: $fromUnitIndex) {
                        ForEach(0 ..< TIME_UNITS.count) { index in
                            Text("\(TIME_UNITS[index].name)")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("To")) {
                    Text("\(toValue, specifier: "%.2f")")
                    Picker("TimeUnits", selection: $toUnitIndex) {
                        ForEach(0 ..< TIME_UNITS.count) { index in
                            Text("\(TIME_UNITS[index].name)")
                        }
                    }.pickerStyle(.segmented)
                }
            }.navigationTitle(Text("Time Conversion"))
        }
    }
}


struct TimeUnit{
    var name: String
    var factor: Double
    init(_ name: String, _ factor: Double){
        self.name = name
        self.factor = factor
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
