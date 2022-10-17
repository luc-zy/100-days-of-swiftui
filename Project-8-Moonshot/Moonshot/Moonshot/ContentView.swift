//
//  ContentView.swift
//  Moonshot
//
//  Created by 张洋 on 2022/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ geo in
            VStack {
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.85)
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10) {
                        ForEach(0..<100) {
                            Text("Item \($0)")
                                .font(.title)
                        }
                    }
                }
                NavigationView {
                    VStack{
                        NavigationLink {
                            Button("Decode"){
                                let input = """
                                    {
                                        "name": "Taylor Swift",
                                        "address": {
                                            "street": "555, Taylor Swift Avenue",
                                            "city": "Nashville"
                                        }
                                    }
                                """
                                if let user = try? JSONDecoder().decode(User.self, from: Data(input.utf8)){
                                    print(user)
                                }
                            }
                        } label: {
                            Text("Decode")
                        }
                        NavigationLink {
                            ScrollView(.vertical){
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                                    ForEach(0..<1000){item in
                                        Text("Item \(item)")
                                    }
                                }
                            }
                        } label: {
                            Text("GridView")
                        }
                        List(0..<100){row in
                            NavigationLink {
                                Text("Detail \(row)")
                            } label: {
                                Text("Row \(row)")
                            }
                        }
                    }
                    .navigationTitle("SwiftUI")
                }
            }.frame(width: geo.size.width, height: geo.size.height)
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
