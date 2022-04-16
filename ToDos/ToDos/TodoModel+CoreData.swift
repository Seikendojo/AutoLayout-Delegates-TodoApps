//
//  TodoModel+CoreData.swift
//  ToDos
//
//  Created by Shahin on 2022-04-16.
//

import Foundation
import CoreData

public class TodoModel: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var priorityEnum: Int16
    @NSManaged public var isCompleted: Bool
    @NSManaged public var owner: PersonModel
    var priority: Priority {
        get{ return (Priority.init(rawValue: Int(priorityEnum)) ?? .none)! }
        set{ priorityEnum = Int16(newValue.rawValue)  }
    }
}
