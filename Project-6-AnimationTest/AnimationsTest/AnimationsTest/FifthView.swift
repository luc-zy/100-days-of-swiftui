//
//  FifthView.swift
//  AnimationsTest
//
//  Created by 张洋 on 2022/6/29.
//

import SwiftUI

struct FifthView: View {
    @State var isShowing = false
    var body: some View {
        VStack{
            Button("Change Rectangle") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isShowing.toggle()
                }
            }
            
            if isShowing {
                RadialGradient(colors: [.blue, .white], center: .center, startRadius: 0, endRadius: 360)
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct FifthView_Previews: PreviewProvider {
    static var previews: some View {
        FifthView()
    }
}
