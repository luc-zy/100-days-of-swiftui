//
//  ContentView.swift
//  Friends
//
//  Created by zhangyang on 26/6/2024.
//

import SwiftUI

struct ContentView: View {
    @State var store = PersonStore()
    @State var refreshButtonDegrees = 0.0
    @State var deleteButtonTilt = false
    
    var body: some View {
        NavigationStack(path: $store.path) {
            List {
                if let people = store.people {
                    Section {
                        Text("Informations of \(people.count) person")
                    }
                    Section {
                        ForEach(people) { person in
                            NavigationLink(value: person.id) {
                                HStack {
                                    Image(systemName: "person")
                                    Text(person.name)
                                    Spacer()
                                    Image(systemName: "circle.fill")
                                        .foregroundStyle(person.isActive ? .green : .red)
                                }
                            }
                        }
                    }
                }else{
                    Text("No data")
                }
            }
            .navigationTitle("Friends")
            .navigationDestination(for: String.self, destination: { id in
                DetailView(personId: id).environment(store)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .destructive) {
                        deleteButtonTilt = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            deleteButtonTilt = false
                        }
                        withAnimation {
                            store.clearData()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                            .rotationEffect(.degrees(deleteButtonTilt ? -15 : 0), anchor: .bottom)
                            .animation(.spring(duration: 0.8), value: deleteButtonTilt)
                    }.sensoryFeedback(.warning, trigger: deleteButtonTilt)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            refreshButtonDegrees += 360
                        }
                        Task {
                            await store.loadData()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.blue)
                            .rotationEffect(.degrees(refreshButtonDegrees))
                    }.sensoryFeedback(.increase, trigger: refreshButtonDegrees)
                }
            })
            .task {
                await store.loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}
