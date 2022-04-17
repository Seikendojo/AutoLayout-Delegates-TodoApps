//
//  Todo.swift
//  ToDos
//
//  Created by Shahin on 2021-12-27.
//

import UIKit

enum Priority: Int {
    case low
    case medium
    case high

    var symbol: String {
        switch self {
        case .low: return "!"
        case .medium: return "!!"
        case .high: return "!!!"
        }
    }

    var color: UIColor {
        switch self {
        case .low: return .todoGreen
        case .medium: return .todoYellow
        case .high: return .todoRed
        }
    }
}

struct Todo {
    var id = UUID().uuidString
    var title: String
    var date: Date
    var priority: Priority
    var owner: Person
    var isCompleted = false

    func update(_ todoModel: inout TodoModel) -> TodoModel {
        todoModel.title = title
        todoModel.date = date
        todoModel.priority = priority
        todoModel.id = id
        todoModel.isCompleted = isCompleted
        return todoModel
    }

    static func parse(from todoModel: TodoModel) -> Todo {
        Todo(id: todoModel.id,
             title: todoModel.title,
             date: todoModel.date,
             priority: todoModel.priority,
             owner: Person.parse(from: todoModel.owner),
             isCompleted: todoModel.isCompleted)
    }
}

