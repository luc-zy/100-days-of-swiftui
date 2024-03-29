//
//  EmojyRatingView.swift
//  BookWorm
//
//  Created by 张洋 on 2023/8/30.
//

import SwiftUI

struct EmojyRatingView: View {
    let rating: Int16
    var body: some View {
        switch rating{
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

struct EmojyRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojyRatingView(rating: 3)
    }
}
