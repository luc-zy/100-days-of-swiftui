//
//  MissionCardView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/25.
//

import SwiftUI

struct MissionCardView: View {
    @State var showMode: ContentViewShowMode = .grid
    let mission: Mission
    var body: some View {
        
        let cardLable: some View = VStack{
            Text(mission.displayName)
                .font(.headline)
                .foregroundColor(.white)
            Text(mission.formmattedLaunchDate)
                .font(.caption)
                .foregroundColor(.white.opacity(0.5))
        }.padding().frame(maxWidth: .infinity).background(.lightBackground)
        
        let cardImage: some View = Image(mission.imageName)
        .resizable()
        .scaledToFit()

        
        if showMode == .grid {
            VStack{
                cardImage
                    .frame(width: 100, height: 100)
                    .padding(.vertical)
                cardLable
            }.cardify()
        } else {
            HStack {
                cardImage
                    .frame(width: 50, height: 50)
                    .padding(.horizontal)
                cardLable
            }.cardify()
        }
    }
}

struct Cardify: ViewModifier {
    let cardShape = RoundedRectangle(cornerRadius: 10)
    
    func body(content: Content) -> some View {
        content.clipShape(cardShape)
            .overlay(cardShape.stroke(.lightBackground))
    }
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let missions: [Mission]  = Bundle.main.decode("missions.json")
        MissionCardView(mission: missions[0])
    }
}
