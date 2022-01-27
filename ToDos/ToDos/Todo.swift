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
    let title: String
    let date: Date
    let priority: Priority
    var isCompleted = false

    var dictionary: [String: Any] {
        ["id": id,
         "title": title,
         "date": date,
         "priority": priority.rawValue,
         "isCompleted": isCompleted]
    }

    static func parse(from dict: [String: Any]) -> Todo? {
        guard let id = dict["id"] as? String,
              let title = dict["title"] as? String,
              let date = dict["date"] as? Date,
              let priority = Priority(rawValue: dict["priority"] as? Int ?? 0),
              let isCompleted = dict["isCompleted"] as? Bool
        else { return nil }
        return Todo(id: id, title: title, date: date, priority: priority, isCompleted: isCompleted)
    }
}
