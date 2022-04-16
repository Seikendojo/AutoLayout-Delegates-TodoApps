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
        Person(firstName: personModel.firstName,
               lastName: personModel.lastName,
               image: UIImage(data: personModel.imageData),
               todos: personModel.todos)
    }

    var personModel: PersonModel {
        let model = PersonModel()
        model.id = id
        model.firstName = firstName
        model.lastName = lastName
        model.imageData = image?.pngData() ?? Data()
        model.todos = todos
        return model
    }
}
