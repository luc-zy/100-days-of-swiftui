//
//  BookWormSwiftDataVerApp.swift
//  BookWormSwiftDataVer
//
//  Created by zhangyang on 13/6/2024.
//

import SwiftUI
import SwiftData

@main
struct BookWormSwiftDataVerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Book.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
