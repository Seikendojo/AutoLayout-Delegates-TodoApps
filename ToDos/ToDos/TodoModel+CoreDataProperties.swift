//
//  TodoModel+CoreDataProperties.swift
//  ToDos
//
//  Created by Sia on 2022-01-29.
//
//

import Foundation
import CoreData


extension TodoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var priorityEnum: Int16
    @NSManaged public var isCompleted: Bool

}

extension TodoModel : Identifiable {

}
