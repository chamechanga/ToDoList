//
//  RoutingReducer.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    
    switch action {
    case let routingAction as RoutingAction:
        state.navigationState = routingAction.destination
    default: break
    }
    return state
}
