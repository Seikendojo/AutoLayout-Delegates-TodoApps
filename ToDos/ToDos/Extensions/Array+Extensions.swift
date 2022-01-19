//
//  Array+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2022-01-17.
//

import Foundation

extension Array where Element == Todo {
    var sortedByDate: [Todo] {
        sorted(by: { $0.date.compare($1.date) == .orderedAscending })
    }
}
