//
//  PersistenceManager.swift
//  ToDos
//
//  Created by Shahin on 2022-01-17.
//

import Foundation
import CoreData
import UIKit

struct PersistencManager {
    static let shared = PersistencManager()

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

     var people: [Person] = {
       var people = [Person]()
         people.append(Person(firstName: "Bruce", lastName: "Lee", image: UIImage(named: "Bruce")!))
         people.append(Person(firstName: "Halle", lastName: "Berry", image: UIImage(named: "HalleBerry")!))
         people.append(Person(firstName: "Brad", lastName: "Pitt", image: UIImage(named: "BradPitt")!))
         people.append(Person(firstName: "Arnold", lastName: "Schwarzenegerk", image: UIImage(named: "Arnold")!))
         return people.sortedLastName
     }()

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
            let todoModel = TodoModel(context: persistentContainer.viewContext)
            todoModel.id = todo.id
            todoModel.title = todo.title
            todoModel.date = todo.date
            todoModel.priority = todo.priority
            todoModel.isCompleted = todo.isCompleted
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

    // MARK: - Core Data stack

     var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TodoModel")
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
