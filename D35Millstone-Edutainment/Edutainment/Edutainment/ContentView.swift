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
    
    @State private var questions = [MultiplicativeExpressions]()
    @State private var inputAnswers = [String](repeating: "", count: 20)
    
    var body: some View {
        NavigationView {
            List{
                Section("Settings"){
                    Stepper("Up to \(upToNumber)", value: $upToNumber, in: 3...12)
                    Picker("Number of questions", selection: $questionNumber) {
                        ForEach(SelectionNumber.allCases) { number in
                            Text(number.rawValue)
                        }
                    }
                }
                Button("Confirm", action: newGame)
                Section("Questions") {
                    ForEach(questions) { question in
                        HStack{
                            Text("What is \(question.firstNumber) x \(question.secondNumber):")
                            Spacer()
                            TextField("input number", text: $inputAnswers[1])
                                .keyboardType(.numberPad)
                        }.transition(.asymmetric(insertion: .slide, removal: .scale))
                    }
                }
                Button("Check!", action: check)
            }.navigationTitle("Edutainment !")
        }.onAppear(perform: newGame)
    }
    
    func check(){
        
    }
    
    func newGame() {
        //TODO: ⚠️解决List动画不生效的问题！
        inputAnswers = [String](repeating: "", count: 20)
        withAnimation(.easeIn) {
            questions = [MultiplicativeExpressions]()
            for i in 0..<questionNumber.numberValue{
                let expresion = MultiplicativeExpressions(
                    Int.random(in: 1...upToNumber),
                    Int.random(in: 1...upToNumber)
//                    id: UUID()
                )
                questions.append(expresion)
            }
        }
    }
}

struct MultiplicativeExpressions: Identifiable {
    var id = UUID()
    var firstNumber: Int
    var secondNumber: Int
    init(_ firstNumber: Int, _ secondNumber: Int){
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
//        self.id = id
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
