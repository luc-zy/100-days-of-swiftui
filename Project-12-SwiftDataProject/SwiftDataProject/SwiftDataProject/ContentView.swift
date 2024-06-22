//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by zhangyang on 14/6/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var path = NavigationPath()
    
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<User>{user in
        user.name.localizedStandardContains("R")
        && user.city == "London"
    }, sort: \User.name)
    
    var users: [User]
    
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    fileprivate func addMockData() {
        withAnimation {
            try? modelContext.delete(model: User.self)
            var first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
            let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
            let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
            let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
            
            modelContext.insert(first)
            modelContext.insert(second)
            modelContext.insert(third)
            modelContext.insert(fourth)
            
            let job1 = Job(name: "Clean kitchen", priority: 3)
            let job2 = Job(name: "Sale unused things", priority: 4)
            let job3 = Job(name: "Read a book", priority: 5)
            
            first.jobs?.append(job1)
            first.jobs?.append(job2)
            third.jobs?.append(job3)
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            UsersView(minJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add Samples", systemImage: "plus") {
                        addMockData()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            showingUpcomingOnly.toggle()
                        }
                    }, label: {
                        Text(showingUpcomingOnly ? "Show everyone" : "Show upcoming")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort") {
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            Text("Sort by joinDate")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
