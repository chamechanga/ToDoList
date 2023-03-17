//
//  TodoListAction.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

struct GetTodoListAction: Action {
    let currentUser: String
}

struct AddTodoItemAction: Action {
    let currentUser: String
    let todoItem: String
}

struct EditTodoItemAction: Action {
    let currentUser: String
    let todoItem: TodoItem
    let newTodoItem: String
    let index: Int
}

struct DeleteTodoItemAction: Action {
    let currentUser: String
    let todoItem: TodoItem
}
