//
//  AddBookView.swift
//  BookWorm
//
//  Created by 张洋 on 2023/7/30.
//

import SwiftUI

struct AddBookView: View {
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section {
                TextEditor(text: $review)
                
                Picker("Rating", selection: $rating) {
                    ForEach(0..<6) {
                        Text(String($0))
                    }
                }
            } header: {
                Text("Write a review")
            }
            
            Section {
                Button("Save") {
                    let newBook = Book(context: moc)
                    newBook.id = UUID()
                    newBook.title = self.title
                    newBook.author = self.author
                    newBook.rating = Int16(self.rating)
                    newBook.genre = self.genre
                    newBook.review = self.review
                    
                    try? moc.save()
                    dismiss()
                }
            }
        }.navigationTitle("Add Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
