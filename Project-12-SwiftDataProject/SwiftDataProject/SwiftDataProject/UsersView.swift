//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by zhangyang on 18/6/2024.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    
    init(minJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> {user in
            user.joinDate > minJoinDate
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user, label: {
                HStack(content: {
                    Text(user.name)
                    Spacer()
                    Text(String(user.unwrapJobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                })
                
            })
        }
    }
}

#Preview {
    UsersView(minJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
