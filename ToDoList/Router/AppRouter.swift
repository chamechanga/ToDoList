//
//  AppRouter.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import ReSwift

enum RoutingDestination {
    case todo
    case landing
    case login
    case signup
    
    func viewController() -> UIViewController {
        switch self {
        case .todo:
            return ToDoViewController()
        case .landing:
            return LandingPageViewController()
        case .login:
            return LoginViewController()
        case .signup:
            return SignupViewController()
        }
    }
}

final class AppRouter {
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController

        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    fileprivate func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(state.navigationState.viewController(), animated: shouldAnimate)
    }
}
