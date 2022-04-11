//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 张洋 on 2022/3/22.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    var correctAnswer = Int.random(in: 0...2)
    
    @State var scoreTitle = ""
    @State var showingScore = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag").font(.title)
                    Text(countries[correctAnswer]).font(.headline)
                }.foregroundColor(.white)
                ForEach(0..<3) { number in
                    Button {
                        if(number == correctAnswer) {
                            scoreTitle = "Correct"
                        }else{
                            scoreTitle = "Wrong"
                        }
                        showingScore = true
                    } label: {
                        Image(countries[number]).renderingMode(.original)
                    }.alert(scoreTitle, isPresented: $showingScore) {
                        Button("OK", role: .cancel) {
                            
                        }
                    }

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
