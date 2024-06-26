//
//  EditBookView.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/30.
//

import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    // ユーザーが編集できる本の属性を保持するための状態変数
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    var body: some View {
        HStack{
            // ユーザーが異なるステータスを選択できるようにするため
            Text("Status")
            Picker("Status",selection: $status){
                ForEach(Status.allCases){ status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading){
            GroupBox{
                LabeledContent{
                    DatePicker("",selection: $dateAdded,displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .completed{
                    LabeledContent {
                        DatePicker("",selection: $dateAdded,in: dateAdded...,displayedComponents: .date)
                    } label: {
                        Text("Date Added")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("",selection: $dateCompleted,in: dateStarted...,displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status){ oldValue,newValue in
                if !firstView{
                    if newValue == .onShelf{
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        // from completed to inProgress
                        dateStarted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // Book has been started
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        // Forgot to start book
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating,width: 30)
            } label: {
                Text("Rating")
            }
            LabeledContent{
                TextField("",text: $title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent{
                TextField("",text: $author)
            } label: {
                Text("Author").foregroundStyle(.secondary)
            }
            Divider()
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $summary)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill),lineWidth: 2))
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if changed{
                // ユーザーがこのボタンをクリックすると、編集された本の情報が保存
                Button("Update"){
                    book.status = status
                    book.rating = rating
                    book.title = title
                    book.author = author
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateCompleted
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        // ビューが表示される際に初期値を設定する
        .onAppear{
            status = book.status
            rating = book.rating
            title = book.title
            author = book.author
            summary = book.summary
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateCompleted = book.dateCompleted
        }
    }
    // 編集前後で情報に変更があるかどうかをチェック
    var changed: Bool {
        status != book.status
        || rating != book.rating
        || title != book.title
        || author != book.author
        || summary != book.summary
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateCompleted != book.dateCompleted
    }
}
