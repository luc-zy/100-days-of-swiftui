//
//  MissionCardView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/25.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    var body: some View {
        VStack{
            Image(mission.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            VStack{
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(mission.formmattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }.clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let missions: [Mission]  = Bundle.main.decode("missions.json")
        MissionCardView(mission: missions[0])
    }
}
