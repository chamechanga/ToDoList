//
//  LocationReducer.swift
//  ToDoList
//
//  Created by Indra on 3/17/23.
//

import ReSwift

func locationReducer(action: Action, state: LocationState?) -> LocationState {
    var state = state ?? LocationState(coordinates: (latitude: 0.0, longitude: 0.0))
    
    switch action {
    case let setLocationAction as SetLocationAction:
        state.coordinates = setLocationAction.coordinates
    default: break
    }
    
    return state
}
