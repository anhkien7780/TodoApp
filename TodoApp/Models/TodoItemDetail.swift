//
//  TodoItemDetail.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

struct TodoItemDetail {
    var id: UUID = UUID()
    var taskTitle: String
    var category: Category?
    var date: String?
    var time: String?
    var isCompleted: Bool
    var note: String?
}
