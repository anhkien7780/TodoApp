//
//  Category.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation

enum Category: String, CaseIterable, Codable{
    case Task = "task"
    case Event = "event"
    case Goal = "goal"
    case None = "none"
}
