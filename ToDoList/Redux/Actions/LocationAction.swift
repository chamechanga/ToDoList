//
//  LocationAction.swift
//  ToDoList
//
//  Created by Indra on 3/17/23.
//

import ReSwift
import CoreLocation

struct FetchLocationAction: Action {
    
}

struct SetLocationAction: Action {
    var coordinates: (latitude: Double, longitude: Double)
}

func getLocationCoordinate(state: AppState, store: Store<AppState>) -> FetchLocationAction {
    let locationManager = CLLocationManager()
    
    locationManager.requestWhenInUseAuthorization()
    let isAuthorized = CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways
    
    if isAuthorized {
        if let coordinate = locationManager.location?.coordinate {
            store.dispatch(SetLocationAction(coordinates: (latitude: coordinate.latitude, longitude: coordinate.longitude)))
        }
    }
    
    return FetchLocationAction()
}
