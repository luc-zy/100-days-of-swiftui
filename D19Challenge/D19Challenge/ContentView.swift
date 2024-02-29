//
//  ContentView.swift
//  D19Challenge
//
//  Created by 张洋 on 2021/9/28.
//

import SwiftUI

struct ContentView: View {
    @State var fromValue: Double = 0
    
    let TIME_UNITS: [TimeUnit] = [
        TimeUnit("Seconds", 1, id: 0),
        TimeUnit("Minutes", 60, id: 1),
        TimeUnit("Hours", 60 * 60, id: 2),
        TimeUnit("Days", 60 * 60 * 24, id: 3)
    ]
    @State var fromUnitIndex: Int = 0
    @State var toUnitIndex: Int = 0
    
    @FocusState var focused: Bool
    
    var toValue: Double{
        fromValue * TIME_UNITS[fromUnitIndex].factor / TIME_UNITS[toUnitIndex].factor
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("From")) {
                    TextField("Value", value: $fromValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focused)
                    Picker("TimeUnits", selection: $fromUnitIndex) {
                        ForEach(TIME_UNITS) { timeUnit in
                            Text("\(timeUnit.name)")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("To")) {
                    Text(toValue.formatted())
                    Picker("TimeUnits", selection: $toUnitIndex) {
                        ForEach(TIME_UNITS) { timeUnit in
                            Text("\(timeUnit.name)")
                        }
                    }.pickerStyle(.segmented)
                }
            }.navigationTitle(Text("Time Conversion"))
                .toolbar(content: {
                    if focused {
                        Button {
                            focused = false
                        } label: {
                            Text("Done")
                        }

                    }
                })
        }
    }
}


struct TimeUnit: Identifiable{
    var name: String
    var factor: Double
    var id: Int
    init(_ name: String, _ factor: Double, id: Int){
        self.name = name
        self.factor = factor
        self.id = id
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
