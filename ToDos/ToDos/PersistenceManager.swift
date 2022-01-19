//
//  PersistenceManager.swift
//  ToDos
//
//  Created by Shahin on 2022-01-17.
//

import Foundation

struct PersistencManager {

    func retrieveTodos() -> [Todo] {
        var todos = [Todo]()
        if let retrievedTodos = UserDefaults.standard.value(forKey: "todos") as? [String: Any] {
            retrievedTodos.values.forEach { todoDict in
                if let todo = Todo.parse(from: todoDict as! [String : Any]) {
                    todos.append(todo)
                }
            }
        }
        return todos
    }

    func save(_ todo: Todo) {
        var todos = UserDefaults.standard.value(forKey: "todos") as? [String: Any] ?? [String: Any]()
        todos[todo.id] = todo.dictionary
        UserDefaults.standard.set(todos, forKey: "todos")
    }

    func delete(_ todo: Todo) {
        var todosDict = UserDefaults.standard.value(forKey: "todos") as? [String: Any]
        todosDict?.removeValue(forKey: todo.id)
        UserDefaults.standard.set(todosDict, forKey: "todos")
    }
}
