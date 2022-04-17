//
//  TodoModel+CoreDataClass.swift
//  ToDos
//
//  Created by Shahin on 2022-04-16.
//
//

import Foundation
import CoreData


public class TodoModel: NSManagedObject {
    var priority: Priority {
        get{ return (Priority.init(rawValue: Int(priorityEnum)) ?? .none)!  }
        set{ priorityEnum = Int16(newValue.rawValue)  }
    }
}
