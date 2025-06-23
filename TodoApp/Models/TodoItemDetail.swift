//
//  TodoItemDetail.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

struct TodoItemDetail: Codable {
    var id: UUID = UUID()
    var taskTitle: String
    var category: Category?
    var date: String?
    var time: String?
    var isCompleted: Bool
    var note: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case taskTitle = "task_title"
        case category, date, time
        case isCompleted = "is_completed"
        case note
    }
}
