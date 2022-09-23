//
//  ContentView.swift
//  StateTest
//
//  Created by 张洋 on 2022/7/31.
//

import SwiftUI

struct ContentView: View {
    @State var showingSecond = false
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("show second view") {
                showingSecond.toggle()
            }.sheet(isPresented: $showingSecond) {
                SecondView(name: "@yzhang")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
