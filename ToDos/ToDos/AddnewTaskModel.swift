//
//  AddnewTaskModel.swift
//  ToDos
//
//  Created by Sia on 2022-01-29.
//

import Foundation



class AddNewTaskViewModel {
    var title: String
    var date: Date
    var priority: Priority
    
    init(title: String, date: Date, priority: Priority) {
        self.title = title
        self.date  = date
        self.priority = priority
    }
    
    func saveTask() {
        PersistencManager.shared.save(title: title, date: date, priority: priority)
    }
}
