//
//  ContentView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/9/23.
//

import SwiftUI

struct ContentView: View {
    @State var showMode: ContentViewShowMode = .list
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                if showMode == .grid {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(misson: mission, astronauts: astronauts)
                            } label: {
                                MissionCardView(mission: mission)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                } else {
                    LazyVStack(alignment: .leading) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(misson: mission, astronauts: astronauts)
                            } label: {
                                HStack {
                                    Image(mission.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(.horizontal)
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formmattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .frame(maxWidth:.infinity)
                                    .padding()
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground)
                                }.padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationTitle("MoonShot")
            .toolbar {
                ToolbarItem {
                    Button {
                        withAnimation {
                            if showMode == .grid {
                                showMode = .list
                            } else {
                                showMode = .grid
                            }
                        }
                    } label: {
                        Text("ToggleViewMode")
                    }
                }
            }
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
