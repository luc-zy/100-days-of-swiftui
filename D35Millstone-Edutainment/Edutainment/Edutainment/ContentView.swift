//
//  ContentView.swift
//  Edutainment
//
//  Created by 张洋 on 2022/7/4.
//

import SwiftUI

struct ContentView: View {
    private static let maxQuestionSize = 20
    @State private var upToNumber = 9
    @State private var questionNumber: SelectionNumber = .five
    
    @State private var questions = [MultiplicativeExpressions]()
    @State private var inputAnswers = [String](repeating: "", count: maxQuestionSize)
    @State private var checkResults = [Int](repeating: 0, count: maxQuestionSize)
    
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
                            TextField("input number", text: $inputAnswers[question.id])
                                .keyboardType(.numberPad)
                        }
                        .foregroundColor(.white)
                        .colorMultiply(checkResults[question.id] >= 0 ? .primary : .red)
                        .opacity(checkResults[question.id] >= 0 ? 1 : 0.5)
                        .rotation3DEffect(Angle.degrees(Double(checkResults[question.id]) * 360.0), axis: (x: 1, y: 0, z: 0))
                        .animation(.easeIn, value: checkResults[question.id])
                    }.onDelete(perform: removeQuestion)
                }
                Button("Check!", action: check)
            }.navigationTitle("Edutainment !")
        }.onAppear(perform: newGame)
    }
    
    func removeQuestion(at idx: IndexSet) {
        questions.remove(atOffsets: idx)
    }
    
    func check(){
        for question in questions {
            let answer = question.firstNumber * question.secondNumber
            let inputAnswer = Int(inputAnswers[question.id]) ?? -1
            if answer == inputAnswer{
                checkResults[question.id] = 1
            }else{
                checkResults[question.id] = -1
            }
        }
        print(checkResults)
    }
    
    func newGame() {
        inputAnswers = [String](repeating: "", count: ContentView.maxQuestionSize)
        checkResults = [Int](repeating: 0, count: ContentView.maxQuestionSize)
        questions = [MultiplicativeExpressions]()
        for i in 0..<questionNumber.numberValue{
            let expresion = MultiplicativeExpressions(
                Int.random(in: 1...upToNumber),
                Int.random(in: 1...upToNumber),
                id: i
            )
            questions.append(expresion)
        }
    }
}

struct MultiplicativeExpressions: Identifiable, Equatable {
    var id: Int
    var firstNumber: Int
    var secondNumber: Int
    init(_ firstNumber: Int, _ secondNumber: Int, id: Int){
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.id = id
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
