//
//  EditBookView.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/30.
//

import SwiftUI

struct EditBookView: View {
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    
    var body: some View {
        HStack{
            Text("Status")
            Picker("Status",selection: $status){
                ForEach(Status.allCases){ status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonBorderShape(/*@START_MENU_TOKEN@*/__tokenizer(ButtonBorderShape, as: "shape: ButtonBorderShape")/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    EditBookView()
}
