//
//  Book.swift
//  SwiftData-Practice
//
//  Created by 水原　樹 on 2024/03/28.
//

import SwiftUI
import SwiftData

// SwiftDataとの統合
@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status
    // 新しいBookオブジェクトを作成する際に必要な情報を引数として受け取る
    init(
        title: String,
        author: String,
        // 現在の日付
        dateAdded: Date = Date.now,
        // 非常に過去の日付
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ){
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    var icon: Image {
        switch status {
            // まだ読まれていない状態
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
            // 読書中の状態
        case .inProgress:
            Image(systemName: "book.fill")
            // 読了した状態
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int,Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self{
        self
    }
    var descr: String{
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "COmpleted"
        }
    }
}
