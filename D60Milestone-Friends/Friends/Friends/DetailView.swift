//
//  DetailView.swift
//  Friends
//
//  Created by zhangyang on 1/7/2024.
//

import SwiftUI

struct DetailView: View {
    @Environment(PersonStore.self) var store: PersonStore
    
    let personId: String
    var targetPerson: Person? {
        store.people?.first(where: { person in
            person.id == personId
        })
    }
    var body: some View {
        List {
            if let person = targetPerson {
                Section("Basic Informations") {
                    HStack{
                        Text(person.name).foregroundStyle(.primary)
                        Spacer()
                        Text("Name").foregroundStyle(.secondary)
                    }
                    HStack{
                        Text(person.address).foregroundStyle(.primary)
                        Spacer()
                        Text("Address").foregroundStyle(.secondary)
                    }
                    Text(person.address)
                    Text(person.age, format: .number)
                    Text(person.registered, format: .dateTime)
                }
                Section("Friend List") {
                    ForEach(person.friends) { friend in
                        NavigationLink(value: friend.id) {
                            HStack {
                                Image(systemName: "person.2")
                                Text(friend.name)
                                Spacer()
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(store.isPersonActive(id: friend.id) ? .green : .red)
                            }
                        }
                    }
                }
                
            }else{
                Text("Could not find person by id: \(personId)")
            }
        }.toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    store.path = NavigationPath()
                }, label: {
                    Label("Go Home", systemImage: "house")
                })
            }
        })
    }
}

#Preview {
    NavigationStack {
        DetailView(personId: "")
            .environment(PersonStore())
    }

}
