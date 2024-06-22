//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by zhangyang on 14/6/2024.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    var body: some View {
        Form(content: {
            Section("Base Info") {
                TextField("Name", text: $user.name)
                TextField("City", text: $user.city)
                DatePicker("JoinDate", selection: $user.joinDate)
            }
            Section("Job Info") {
                ForEach(user.unwrapJobs) { j in
                    HStack {
                        Text(j.name)
                        Spacer()
                        Text(j.priority, format: .number)
                    }
                }
            }
        }).navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do{
        var container = try ModelContainer(for: User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        var user = User(name: "yzhang", city: "chengdu", joinDate: Date())
        return EditUserView(user: user)
            .modelContainer(container)
    } catch{
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
