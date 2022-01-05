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
    let id = UUID()
    let title: String
    let date: Date
    let priority: Priority

    var dictionary: [String: Any] {
        ["id": id.uuidString,
         "title": title,
         "date": date,
         "priority": priority.rawValue]
    }
}
