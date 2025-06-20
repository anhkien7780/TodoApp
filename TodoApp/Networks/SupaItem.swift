//
//  SupaItem.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

struct SupaItem: Decodable {
    var id: UUID
    var taskTitle: String
    var category: String?
    var date: String?
    var time: String?
    var isCompleted: Bool
    var note: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case taskTitle = "task_title"
        case category
        case date
        case time
        case isCompleted = "is_completed"
        case note
    }
}
