//
//  TodoListReducer.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

func todoReducer(action: Action, state: TodoListState?) -> TodoListState {
    var state = state ?? TodoListState()
    var username: String = ""
    
    switch action {
    case let getTodoListAction as GetTodoListAction:
        username = getTodoListAction.currentUser
    case let addListAction as AddTodoItemAction:
        CoreDataManager().createItem(addListAction.todoItem, user: addListAction.currentUser)
        username = addListAction.currentUser
    case let editTodoItemAction as EditTodoItemAction:
        CoreDataManager().editItem(item: editTodoItemAction.todoItem, newTodoItem: editTodoItemAction.newTodoItem)
        username = editTodoItemAction.currentUser
    case let deleteTodoItemAction as DeleteTodoItemAction:
        CoreDataManager().deleteItem(item: deleteTodoItemAction.todoItem)
        username = deleteTodoItemAction.currentUser
    default: break
    }
    
    let todoList = CoreDataManager().getItems()
    state.todo = todoList.filter {
        $0.username == username
    }
    
    return state
}
