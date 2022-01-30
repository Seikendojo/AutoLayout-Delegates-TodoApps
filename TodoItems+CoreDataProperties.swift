//
//  TodoItems+CoreDataProperties.swift
//  ToDos
//
//  Created by Sia on 2022-01-29.
//
//

import Foundation
import CoreData


extension TodoItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItems> {
        return NSFetchRequest<TodoItems>(entityName: "TodoItems")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var priorityEnum: Int16
    @NSManaged public var isCompleted: Bool

}

extension TodoItems : Identifiable {

}
