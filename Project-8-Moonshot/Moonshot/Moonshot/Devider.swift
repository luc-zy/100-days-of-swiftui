//
//  Devider.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/25.
//

import SwiftUI

struct Devider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct Devider_Previews: PreviewProvider {
    static var previews: some View {
        Devider()
    }
}
