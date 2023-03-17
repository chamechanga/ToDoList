//
//  ChangeCurrentUserAction.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

struct ChangeCurrentUserAction: Action {
    let username: String
}

struct GetUsersAction: Action {
}

struct SaveUserAction: Action {
    let username: String
}
