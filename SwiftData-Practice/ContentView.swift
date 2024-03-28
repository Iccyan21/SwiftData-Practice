//
//  ContentView.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/28.
//

import SwiftUI

struct ContentView: View {
    @State private var createNewBook = false
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
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
}
