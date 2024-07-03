//
//  DetailView.swift
//  Friends
//
//  Created by zhangyang on 1/7/2024.
//

import SwiftUI

struct DetailView: View {
    @Environment(PersonStore.self) var store: PersonStore
    
    var tagFontColor: Color = Color(.sRGB, red: 51/255, green: 193/255, blue: 89/255)
    var tagBackgroundColor: Color = .green.opacity(0.16)
    
    let personId: String
    var targetPerson: PersonDto? {
        store.people?.first(where: { person in
            person.id == personId
        })
    }
    var body: some View {
        ScrollView(content: {
            if let person = targetPerson {
                VStack(alignment: .leading,content: {
                    Text(person.name).foregroundStyle(.primary)
                        .font(.largeTitle)
                    Text("\(person.age) years old")
                        .font(.subheadline)
                    Text(person.address)
                        .font(.subheadline)
                    Text(person.registered, format: .dateTime)
                
                    Section("Friends") {
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
                        }.padding(.vertical, 5)
                    }
                }).padding()
            }else{
                Text("Could not find person by id: \(personId)")
            }
        })
        .navigationTitle("Person Info")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
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
