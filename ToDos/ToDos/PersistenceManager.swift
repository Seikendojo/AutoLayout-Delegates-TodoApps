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
    
    private var todosDict: [String: Any]? {
        UserDefaults.standard.value(forKey: "todos") as? [String: Any]
    }

    
    func retrieveTodos() -> [TodoItems] {
        let request = TodoItems.fetchRequest()
        var todoItems = [TodoItems]()
        do {
            todoItems =  try persistentContainer.viewContext.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo) ")
        }
        
        return todoItems
    }
    
    func save(title: String, date: Date, priority: Priority) {
        let todo = TodoItems(context: persistentContainer.viewContext)
        todo.title = title
        todo.date = date
        todo.priority = priority
        todo.id = UUID()
        saveContext()
    }
    
    
    func delete(_ todo: TodoItems) {
        let request = TodoItems.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", todo.id!.uuidString)
        
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
     
        let container = NSPersistentContainer(name: "ToDos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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
    
//    func retrieveTodos() -> [Todo] {
//        var todos = [Todo]()
//        if let retrievedTodos = todosDict {
//            retrievedTodos.values.forEach { todoDict in
//                if let todo = Todo.parse(from: todoDict as! [String : Any]) {
//                    todos.append(todo)
//                }
//            }
//        }
//        return todos
//    }
//
//    func save(_ todo: Todo) {
//        var todosDict = todosDict ?? [String: Any]()
//        todosDict[todo.id] = todo.dictionary
//        UserDefaults.standard.set(todosDict, forKey: "todos")
//    }
//
//    func delete(_ todo: Todo) {
//        var todosDict = self.todosDict
//        todosDict?.removeValue(forKey: todo.id)
//        UserDefaults.standard.set(todosDict, forKey: "todos")
//    }
}
