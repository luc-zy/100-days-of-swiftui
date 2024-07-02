//
//  ContentView.swift
//  D25Millstone-RockPaperAndScissors
//
//  Created by 张洋 on 2022/5/29.
//

import SwiftUI

struct ContentView: View {
    let items = ["Rock", "Paper", "Scissors"]
    @State var computerChoosed = Int.random(in: 0..<3)
    var correctAnswer: Int {
        (computerChoosed + 1) % items.count
    }
    @State var showAlert = false
    @State var alertMessage = ""
    @State var score = 0
    @State var round = 1
    let limit = 3
    var body: some View {
        VStack {
            VStack {
                Text("Rock, Paper And Scissors")
                    .font(.largeTitle.weight(.heavy))
                    .padding()
                Spacer()
                Text(items[computerChoosed])
                    .font(.title.weight(.semibold))
                    .foregroundColor(.secondary)
                Spacer()
            }.frame(maxWidth:.infinity, maxHeight: .greatestFiniteMagnitude)
            Spacer()
            VStack {
                Spacer()
                Text("The right answer is ??")
                Spacer()
                HStack{
                    ForEach(items, id: \.self) { item in
                        Spacer()
                        Button {
                            answerTapped(item)
                        } label: {
                            Text(item)
                        }.alert("Alert", isPresented: $showAlert) {
                            Button(role: .cancel) {
                                nextRound()
                            } label: {
                                Text("OK")
                            }
                        } message: {
                            Text(alertMessage)
                        }
                        Spacer()
                    }
                }
                Spacer()
                Text("Score: \(score)")
                Spacer()
            }
            
        }
    }
    
    func nextRound(){
        round += 1
        computerChoosed = Int.random(in: 0..<3)
        
    }
    
    func answerTapped(_ answer: String){
        if round > limit{
            return
        }
        if correctAnswer == items.firstIndex(of: answer) {
            alertMessage = "Right"
            score += 1
        }else{
            alertMessage = "Wrong"
            score -= 1
        }
        if round == limit{
            alertMessage = "GG, your final score is \(score)"
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
