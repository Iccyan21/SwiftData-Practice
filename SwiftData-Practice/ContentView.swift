//
//  ContentView.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query (sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false
    var body: some View {
        NavigationStack{
            Group{
                if books.isEmpty{
                    ContentUnavailableView("Enter your first book.",
                                           systemImage: "book.fill")
                } else {
                    List{
                        ForEach(books){ book in
                            NavigationLink{
                                Text(book.title)
                            } label: {
                                HStack(spacing: 10){
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack{
                                                ForEach(0..<rating, id:\.self){
                                                    _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        // スライドしたら削除
                        .onDelete { IndexSet in
                            IndexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Books")
            .toolbar{
                Button{
                    createNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook){
                NewBookView().presentationDetents([.medium])
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self,inMemory: true)
}
