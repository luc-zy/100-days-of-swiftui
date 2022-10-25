//
//  MissionView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/21.
//

import SwiftUI

struct MissionView: View {
    let misson: Mission
    let crew: [CrewMember]
    
    init(misson: Mission, astronauts: [String: Astronaut]) {
        self.misson = misson
        self.crew = misson.crew.map({ member in
            guard let astronaut =  astronauts[member.name] else {
                fatalError("Missing \(member.name)")
            }
            return CrewMember(role: member.role, astronaut: astronaut)
        })
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(misson.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)
                    Text("Mission Date: \(misson.formmattedLaunchDate)")
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Devider()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(misson.description)
                        Devider()
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }.padding(.horizontal)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(crew, id: \.role) { crew in
                                NavigationLink {
                                    AstronautView(astronaut: crew.astronaut)
                                } label: {
                                    HStack{
                                        Image(crew.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle().strokeBorder(.white, lineWidth: 1)
                                            }
                                        VStack(alignment: .leading) {
                                            Text(crew.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crew.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }.padding()
                                }
                            }
                        }
                    }
                }.padding(.bottom)
            }
        }.navigationTitle(misson.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
//        let misson: Mission = Mission(id: 1, launchDate: nil, crew: [Mission.CrewRole(name: "yzhang", role: "astronaut")], description: "TestMission")
        //⚠️为什么使用自己构造的和数组中的显示效果会不一样？
        MissionView(misson: missions[0], astronauts: astronauts)
    }
}
