//
//  ThirdView.swift
//  AnimationsTest
//
//  Created by 张洋 on 2022/6/28.
//

import SwiftUI

struct ThirdView: View {
    @State var enable = false;
    var body: some View {
        Button("Tap Me") {
            enable.toggle()
        }.frame(width: 200, height: 200, alignment: .center)
        .background(enable ? .red : .blue)
        .animation(nil, value: enable)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enable ? 0 : 60))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enable)
        
            
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
