//
//  ContentView.swift
//  Edutainment
//
//  Created by 张洋 on 2022/7/4.
//

import SwiftUI

struct ContentView: View {
    @State private var upToNumber = 9
    @State private var questionNumber: SelectionNumber = .five
    
    var body: some View {
        NavigationView{
            List{
                Section("Settings"){
                    Stepper("Up to \(upToNumber)", value: $upToNumber, in: 3...12)
                    
                    VStack(alignment: .leading) {
                        Text("Number of questions")
                        Picker("Number of questions", selection: $questionNumber) {
                            ForEach(SelectionNumber.allCases) { number in
                                Text(number.rawValue)
                            }
                        }.pickerStyle(.segmented)
                    }
                }
                NavigationLink(destination: QuestionsView(number: questionNumber.numberValue, upTo: upToNumber)) {
                    Text("Go to answer questions...")
                }
            }.navigationTitle("Edutainment")
        }
    }
}


enum SelectionNumber: String, Identifiable, CaseIterable{
    case five, ten, twenty
    
    var id: Self{ self }
    
    var numberValue:Int {
        var number = 0
        switch self {
        case .five:
            number = 5
        case .ten:
            number = 10
        case .twenty:
            number = 20
        }
        return number
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
