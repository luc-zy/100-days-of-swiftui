//
//  GuessTheFlagGameModel.swift
//  GuessTheFlag
//
//  Created by 张洋 on 2022/5/23.
//

import Foundation

struct GuessTheFlagGameModel {
    var countries =  ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer: Int
    var round = 1
    let limit: Int
    var score = 0
    var isLastRound: Bool { (round + 1) > limit }
    
    
    init(limit: Int){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.limit = limit
    }
    
    func isCorretAnswer(_ index: Int) -> Bool {
        return index == correctAnswer
    }
    
    mutating func nextRound(){
        if !isLastRound {
            round += 1
        } else{
            round = 1
            score = 0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    mutating func calculateScore(countryIndex: Int){
        countryIndex == correctAnswer ? (score += 1) : (score -= 1)
    }
}
