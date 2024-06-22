//
//  DetailView.swift
//  Navigation
//
//  Created by zhangyang on 18/6/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
//    
//    var representation: String {
//        do{
//            return try JSONEncoder().encode(path.codable)
//        } catch{
//            print("error")
//            return ""
//        }
//    }

    var body: some View {
        VStack {
            NavigationLink("go to a random number", value: Int.random(in: 0..<100))
                .toolbar(content: {
                    ToolbarItem {
                        Button("Go Home") {
                            path = NavigationPath()
                        }
                    }
                })
        }
    }
}

#Preview {
    var binding = Binding {
        NavigationPath()
    } set: { _ in}
    return DetailView(number: 1, path: binding)
}

