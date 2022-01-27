//
//  Date+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2021-12-27.
//

import Foundation

extension Date {
    var now: Date {
        Date()
    }

    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    /// returns date string in the format of `Dec 28, 2021`
    var shortDateString: String {
        if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        }
        if Calendar.current.isDateInToday(self) {
            return "Today"
        }
        if Calendar.current.isDateInTomorrow(self) {
            return "Tomorrow"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
}
