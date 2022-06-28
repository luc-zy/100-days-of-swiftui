//
//  NextView.swift
//  AnimationsTest
//
//  Created by 张洋 on 2022/6/28.
//

import SwiftUI

struct NextView: View {
    @State var animationAmount:Double  = 0
    var body: some View {
        Button("Tap Me") {
            withAnimation(.easeInOut(duration: 1)) {
                animationAmount += 360
            }
        }.padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(Angle.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
    }
}
