//
//  PersistenceManager.swift
//  ToDos
//
//  Created by Shahin on 2022-01-17.
//

import Foundation

struct PersistencManager {

    private var todosDict: [String: Any]? {
        UserDefaults.standard.value(forKey: "todos") as? [String: Any]
    }

    func retrieveTodos() -> [Todo] {
        var todos = [Todo]()
        if let retrievedTodos = todosDict {
            retrievedTodos.values.forEach { todoDict in
                if let todo = Todo.parse(from: todoDict as! [String : Any]) {
                    todos.append(todo)
                }
            }
        }
        return todos
    }

    func save(_ todo: Todo) {
        var todosDict = todosDict ?? [String: Any]()
        todosDict[todo.id] = todo.dictionary
        UserDefaults.standard.set(todosDict, forKey: "todos")
    }

    func delete(_ todo: Todo) {
        var todosDict = self.todosDict
        todosDict?.removeValue(forKey: todo.id)
        UserDefaults.standard.set(todosDict, forKey: "todos")
    }
}
