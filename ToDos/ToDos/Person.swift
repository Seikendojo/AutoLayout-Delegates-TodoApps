//
//  Person.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-11.
//

import UIKit

struct Person {
    let firstName: String
    let lastName: String
    let image: UIImage
    
    var fullName: String {
        firstName + " " + lastName
    }
}
