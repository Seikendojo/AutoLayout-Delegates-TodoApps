//
//  TodoStore.swift
//  ToDos
//
//  Created by Sia on 2022-02-17.
//

import Foundation

class TodoStore {
    
    var allTodos = [[Todo](),[Todo]()]
    
    func addTodo(_ todo: Todo, at index: Int, isDone: Bool = false) {
        let section = isDone ? 0 : 1
        allTodos[section].insert(todo, at: index)
    }
    
    func removeTodo(at index: Int, isDone: Bool = false) -> Todo {
        let section = isDone ? 0 : 1
        let removingTodo = allTodos[section].remove(at: index)
        return removingTodo
    }
}
