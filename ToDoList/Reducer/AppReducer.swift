//
//  AppReducer.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(routingState: routingReducer(action: action, state: state?.routingState))
}
