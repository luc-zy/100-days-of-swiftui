//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by 张洋 on 2022/5/29.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    init (_ imageName: String){
        self.imageName = imageName
    }
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
        //使用clipShape来控制图片形状,使用shadow来控制阴影
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage("UK")
    }
}
