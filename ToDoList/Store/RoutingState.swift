//
//  RoutingState.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .landing) {
        self.navigationState = navigationState
    }
}
