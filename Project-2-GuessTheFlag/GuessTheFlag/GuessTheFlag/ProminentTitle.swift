//
//  ProminentTitle.swift
//  GuessTheFlag
//
//  Created by 张洋 on 2022/5/29.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    var color: Color
    init(_ color: Color){
        self.color = color
    }
    func body(content: Content) -> some View {
        content.font(.title.bold()).foregroundColor(color)
    }
}
