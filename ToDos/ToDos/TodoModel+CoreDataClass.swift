//
//  TodoModel+CoreDataClass.swift
//  ToDos
//
//  Created by Sia on 2022-01-29.
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
