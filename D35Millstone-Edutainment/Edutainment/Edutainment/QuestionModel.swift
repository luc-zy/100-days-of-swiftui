//
//  QuestionModel.swift
//  Edutainment
//
//  Created by 张洋 on 2022/7/6.
//

import Foundation

struct QuestionModel: Identifiable, Equatable{
    var id: Int
    var firstNumber: Int
    var secondNumber: Int
    var animalOwner: String
    init(_ firstNumber: Int, _ secondNumber: Int, animalOwner: String, id: Int){
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.animalOwner = animalOwner
        self.id = id
    }
}
