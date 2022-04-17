//
//  TodoModel+CoreDataProperties.swift
//  ToDos
//
//  Created by Shahin on 2022-04-16.
//
//

import Foundation
import CoreData


extension TodoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var isCompleted: Bool
    @NSManaged public var priorityEnum: Int16
    @NSManaged public var title: String
    @NSManaged public var owner: PersonModel

}

extension TodoModel : Identifiable {

}
