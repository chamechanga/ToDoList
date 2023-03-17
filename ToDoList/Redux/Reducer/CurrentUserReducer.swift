//
//  CurrentUserReducer.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

func currentUserReducer(action: Action, state: CurrentUserState?) -> CurrentUserState {
    let currentUser = UserDefaultsManager.getCurrentUser()
    var state = state ?? CurrentUserState(currentUser: currentUser)
    
    switch action {
    case let changeUserAction as ChangeCurrentUserAction:
        let newCurrentUser = changeUserAction.username
        UserDefaultsManager.setCurrentUser(newCurrentUser)
        state.currentUser = newCurrentUser
    default: break
    }
    
    return state
}
