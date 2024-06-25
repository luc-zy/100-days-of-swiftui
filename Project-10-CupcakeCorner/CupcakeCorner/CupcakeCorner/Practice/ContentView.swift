//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by zhangyang on 22/6/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 200)
            
            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)

                
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }.task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodeResponse.results
            }
        } catch {
            print("Can't get data from itunes")
        }

    }
}

#Preview {
    ContentView()
}
