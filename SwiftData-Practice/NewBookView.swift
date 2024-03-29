//
//  NewBookView.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/28.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    var body: some View {
        NavigationStack{
            Form{
                TextField("Book Title",text: $title)
                TextField("Autohr",text: $author)
                Button("Create"){
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("New Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cansel"){
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
