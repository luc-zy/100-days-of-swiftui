//
//  TestView.swift
//  Edutainment
//
//  Created by 张洋 on 2022/7/6.
//

import SwiftUI

struct QuestionsView: View {
    @State private var questions: [QuestionModel]
    @State private var inputAnswers: [String]
    @State private var checkResults: [Int]
    
    private static let animals = ["zebra","bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale"]
    
    init(number: Int, upTo: Int){
        print(number, upTo)
        self.inputAnswers = [String](repeating: "", count: number)
        self.checkResults = [Int](repeating: 0, count: number)
        
        var newQuestions = [QuestionModel]()
        for i in 0..<number{
            print(i)
            let expresion = QuestionModel(
                Int.random(in: 1...upTo),
                Int.random(in: 1...upTo),
                animalOwner: (QuestionsView.animals.randomElement() ?? "pig"),
                id: i
            )
            newQuestions.append(expresion)
        }
        print(newQuestions)
        self.questions = newQuestions
    }
    
    var body: some View {
        List{
            ForEach(questions) { question in
                HStack{
                    Image(question.animalOwner)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 50, alignment: .center)
                    Text("want to know: ")
                    VStack {
                        Text("What is \(question.firstNumber) x \(question.secondNumber):")
                            .foregroundColor(.white)
                            .colorMultiply(checkResults[question.id] >= 0 ? .primary : .red)
                            .opacity(checkResults[question.id] >= 0 ? 1 : 0.5)
                            .rotation3DEffect(Angle.degrees(Double(checkResults[question.id]) * 360.0), axis: (x: 1, y: 0, z: 0))
                            .animation(.easeIn, value: checkResults[question.id])
                        TextField("number", text: $inputAnswers[question.id])
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 100)
                            .keyboardType(.numberPad)
                    }
                }
                
            }.onDelete(perform: removeQuestion)
            Button("Check!", action: check)
        }
            .navigationTitle("Questions")
//            .navigationBarTitleDisplayMode(.inline)
        
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
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(number: 5, upTo: 9)
    }
}
