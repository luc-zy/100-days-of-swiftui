//
//  ContentView.swift
//  AnimationsTest
//
//  Created by 张洋 on 2022/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var animationAmount = 1.0
    var body: some View {
        print(animationAmount)
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10).padding()
            Spacer()
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1) * 3)
            .overlay {
                Circle()
                    .stroke(.blue)
//                    .background(Circle().foregroundColor(.blue))
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
            }
            .onAppear {
                animationAmount = 2
            }
            
//        .animation(.easeOut, value: animationAmount)
//            .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
//            .animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true),value: animationAmount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
