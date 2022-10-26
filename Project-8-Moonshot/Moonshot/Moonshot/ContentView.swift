//
//  ContentView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/9/23.
//

import SwiftUI

struct ContentView: View {
    @State var showMode: ContentViewShowMode = .grid
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                if showMode == .grid {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(missions ) { mission in
                            NavigationLink {
                                MissionView(misson: mission, astronauts: astronauts)
                            } label: {
                                MissionCardView(showMode: showMode, mission: mission)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing)
                                .combined(with: .scale).combined(with: .opacity),
                            removal: .move(edge: .trailing)
                                .combined(with: .scale).combined(with: .opacity)
                        ))
                } else {
                    LazyVStack(alignment: .leading) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(misson: mission, astronauts: astronauts)
                            } label: {
                                MissionCardView(showMode: showMode, mission: mission)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading)
                                .combined(with: .scale).combined(with: .opacity),
                            removal: .move(edge: .leading)
                                .combined(with: .scale).combined(with: .opacity)
                        ))
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationTitle("MoonShot")
            .toolbar {
                ToolbarItem {
                    Picker("ToggleShowMode", selection: $showMode.animation(.easeInOut.speed(0.5))) {
                        ForEach(ContentViewShowMode.allCases) { mode in
                            Text(mode.rawValue.capitalized)
                        }
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
