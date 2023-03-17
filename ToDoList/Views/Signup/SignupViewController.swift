//
//  SignupViewController.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    // TODO: - [Non-prio] Fix UI setup and design
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.dispatch(RoutingAction(destination: .signup))
    }
    
    // TODO: - [Non-prio] Add validation
    @IBAction func signup(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        FirebaseAuthManager.signup(email: email, password: password) { result in
            switch result {
            case .success:
                store.dispatch(ChangeCurrentUserAction(username: email))
                store.dispatch(SaveUserAction(username: email))
                store.dispatch(RoutingAction(destination: .landing))
            case .failure:
                print("failure")
            }
        }
    }
}
