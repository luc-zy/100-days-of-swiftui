//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 张洋 on 2022/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)
    
    @State var scoreTitle = ""
    @State var showingScore = false
    @State var score = 0
    
    func newGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    fileprivate func flagTapped(_ number: Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            score -= 1
        }
        showingScore = true
    }
    
    var body: some View {
        ZStack {
//            Color.blue.ignoresSafeArea()
//            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
//            RadialGradient(stops: [.init(color: .blue, location: 0.3), .init(color: .black, location: 0.3)], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag").font(.largeTitle.weight(.bold)).foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        //使用.weight来控制字重
                        Text("Tap the flag").font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
//                    .foregroundColor(.white)
                    //使用.foregroundStyle(.secondary)可以透出一点底色
                    .foregroundStyle(.secondary)
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                            //使用clipShape来控制图片形状,使用shadow来控制阴影
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }.alert(scoreTitle, isPresented: $showingScore) {
                            //⚠️alert 放在哪都没关系，只和监听的isPresented有关
                            Button("OK", role: .cancel, action: newGame)
                        } message: {
                            Text("Your score is \(score)")
                        }

                    }
                }
                //⚠️使用.frame来控制Stack的外形
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                //⚠️多个Spacer会平均分配剩余空间，使用连续两个来控制占位
                Spacer()
                Spacer()
                Text("Score xxx").font(.title.bold()).foregroundColor(.white)
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
