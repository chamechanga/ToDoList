//
//  UsersReducer.swift
//  ToDoList
//
//  Created by Indra on 3/17/23.
//

import ReSwift

func usersReducer(action: Action, state: UsersState?) -> UsersState {
    var state = state ?? UsersState(users: [])
    
    switch action {
    case let saveUserAction as SaveUserAction:
        UserDefaultsManager.saveNew(username: saveUserAction.username)
    default: break
    }
    
    let users = UserDefaultsManager.getUsers()
    state.users = users
    
    return state
}
