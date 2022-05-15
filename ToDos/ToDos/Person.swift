//
//  Person.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-11.
//

import UIKit

struct Person {
    var id = UUID().uuidString
    let firstName: String
    let lastName: String
    let image: UIImage?
    let todos: NSSet?
    
    var fullName: String {
        firstName + " " + lastName
    }

    static func parse(from personModel: PersonModel) -> Person {
        Person(id: personModel.id,
               firstName: personModel.firstName,
               lastName: personModel.lastName,
               image: personModel.imageData.image,
               todos: personModel.todos)
    }
}
