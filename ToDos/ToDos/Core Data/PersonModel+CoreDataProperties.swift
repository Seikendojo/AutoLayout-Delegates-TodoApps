//
//  PersonModel+CoreDataProperties.swift
//  ToDos
//
//  Created by Shahin on 2022-04-16.
//
//

import Foundation
import CoreData


extension PersonModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonModel> {
        return NSFetchRequest<PersonModel>(entityName: "PersonModel")
    }

    @NSManaged public var firstName: String
    @NSManaged public var id: String
    @NSManaged public var imageData: Data
    @NSManaged public var lastName: String
    @NSManaged public var todos: NSSet?

}

// MARK: Generated accessors for todos
extension PersonModel {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: TodoModel)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: TodoModel)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}

extension PersonModel : Identifiable {

}
