//
//  PersonModel+CoreData.swift
//  ToDos
//
//  Created by Shahin on 2022-04-16.
//

import Foundation
import CoreData

//@objc(PersonModel)
public class PersonModel: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonModel> {
        return NSFetchRequest<PersonModel>(entityName: "PersonModel")
    }

    @NSManaged public var firstName: String
    @NSManaged public var id: String
    @NSManaged public var imageData: Data
    @NSManaged public var lastName: String
    @NSManaged public var todos: NSSet?
}
