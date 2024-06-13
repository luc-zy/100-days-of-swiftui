//
//  DetailView.swift
//  BookWormSwiftDataVer
//
//  Created by zhangyang on 13/6/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: Book
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView {
            Image(book.genre)
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottomTrailing) {
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -70, y: -10)
                }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            //🔺想重复使用视图，但是又不想提供绑定变量的做法
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            Button("Delete this book", systemImage: "trash"){
                showingDeleteAlert = true
            }
        }
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure?")
        }

    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    let schema = Schema([
        Book.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        var container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        return DetailView(book: Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4))
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
