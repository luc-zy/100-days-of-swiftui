//
//  ForthView.swift
//  AnimationsTest
//
//  Created by 张洋 on 2022/6/29.
//

import SwiftUI

struct ForthView: View {
    
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var enable = true
    
    var body: some View {
        VStack{
            Spacer()
            LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .animation(.spring(), value: dragAmount)
                .gesture(
                    DragGesture().onChanged({
                        dragAmount = $0.translation
                    }).onEnded({ _ in
                        dragAmount = CGSize.zero
                    })
                )
            Spacer()
            //使用gesture、offset、animation-delay
            HStack(spacing: 0){
                ForEach(0..<letters.count, id:\.self){ num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enable ? .red : .blue)
                        .offset(dragAmount)
                        .animation(.easeInOut.delay(Double(num)/20), value: dragAmount)
                }
            }.gesture(
                DragGesture().onChanged({
                    dragAmount = $0.translation
                }).onEnded({ _ in
                    dragAmount = CGSize.zero
                    enable.toggle()
                })
            )
            Spacer()
        }
    }
}

struct ForthView_Previews: PreviewProvider {
    static var previews: some View {
        ForthView()
    }
}
