//
//  UserState.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

struct CurrentUserState: StateType {
    var currentUser: String
    init(currentUser: String) {
        self.currentUser = currentUser
    }
}
