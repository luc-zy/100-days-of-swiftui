//
//  ContentView.swift
//  Navigation
//
//  Created by zhangyang on 18/6/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var path = PathStore()
    
    
    var body: some View {
        NavigationStack(path: $path.path) {
            DetailView(number: 0, path: $path.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path.path)
                }
        }
    }
}

#Preview {
    ContentView()
}
