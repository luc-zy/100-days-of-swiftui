//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by zhangyang on 14/6/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
