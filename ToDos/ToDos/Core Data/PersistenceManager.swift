//
//  PersistenceManager.swift
//  ToDos
//
//  Created by Shahin on 2022-01-17.
//

import Foundation
import CoreData
import UIKit

struct PersistenceManager {
    static let shared = PersistenceManager()

    private var todoModels: [TodoModel] {
        let request = TodoModel.fetchRequest()
        let todoModels = try? persistentContainer.viewContext.fetch(request)
        return todoModels ?? [TodoModel]()
    }

    var todos: [Todo] {
        var todos = [Todo]()
        todoModels.forEach({ todos.append(Todo.parse(from: $0)) })
        return todos
    }

    private var personModels: [PersonModel] {
        let request = PersonModel.fetchRequest()
        let personModels = try? persistentContainer.viewContext.fetch(request)
        return personModels ?? [PersonModel]()
    }
    
     var people: [Person] {
         var people = [Person]()
         personModels.forEach({ people.append(Person.parse(from: $0)) })
         return people
     }

    var todosDict: [String: [Todo]] {
        var dict = [String: [Todo]]()
        dict[Section.todo.title] = todos.filter({ !$0.isCompleted }).sortedByDate
        dict[Section.done.title] = todos.filter({ $0.isCompleted }).sortedByDate
        return dict
    }

    func save(todo: Todo) {
        if todos.contains(where: { $0.id == todo.id }) {
            let request = TodoModel.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", todo.id)

            do {
                let context = persistentContainer.viewContext
                let result = try context.fetch(request)
                if result.count > 0 {
                    var todoModel = result.first!
                    todoModel = todo.update(&todoModel)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error) \(error.userInfo) ")
            }
        } else {
            let personModel = PersonModel(context: persistentContainer.viewContext)
            personModel.id = todo.owner.id
            personModel.firstName = todo.owner.firstName
            personModel.lastName = todo.owner.lastName

            let todoModel = TodoModel(context: persistentContainer.viewContext)
            todoModel.id = todo.id
            todoModel.title = todo.title
            todoModel.date = todo.date
            todoModel.priority = todo.priority
            todoModel.isCompleted = todo.isCompleted
            todoModel.owner = personModel
        }
        saveContext()
    }

    func delete(_ todo: Todo) {
        let request = TodoModel.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", todo.id)

        do {
            let context = persistentContainer.viewContext
            let result = try context.fetch(request)
            if result.count > 0 {
                let todo = result.first!
                context.delete(todo)
                saveContext()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo) ")
        }
    }

    func save(person: Person) {
        let personModel = PersonModel(context: persistentContainer.viewContext)
        personModel.id = person.id
        personModel.firstName = person.firstName
        personModel.lastName = person.lastName
        personModel.imageData = person.image?.pngData() ?? Data()
        personModel.todos = person.todos
        saveContext()
    }

    func delete(_ person: Person) {
        let request = PersonModel.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", person.id)

        do {
            let context = persistentContainer.viewContext
            let result = try context.fetch(request)
            if result.count > 0 {
                let person = result.first!
                context.delete(person)
                saveContext()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo) ")
        }
    }

    // MARK: - Core Data stack

     var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TodoContainer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
              
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
