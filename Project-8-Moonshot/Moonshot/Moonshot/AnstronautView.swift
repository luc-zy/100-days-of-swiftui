//
//  AstronautView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/24.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack{
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).strokeBorder(.white, lineWidth: 1)
                        }.padding(.vertical)
                    VStack{
                        Text(astronaut.name)
                            .font(.title.bold())
                        Devider()
                        VStack(alignment: .leading) {
                            Text("Astronaut Highlights")
                                .font(.title2.bold())
                                .padding(.bottom)
                            Text(astronaut.description)
                        }
                    }
                }.padding(.horizontal)
            }
        }.navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] =  Bundle.main.decode("astronauts.json")
        AstronautView(astronaut: astronauts["grissom"]!).preferredColorScheme(.dark)
    }
}
