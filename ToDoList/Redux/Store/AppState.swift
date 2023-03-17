//
//  AppState.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    let currentUserState: CurrentUserState
    let todoListState: TodoListState
    let locationState: LocationState
    let usersState: UsersState
}
