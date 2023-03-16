//
//  FirebaseAuthManager.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import FirebaseAuth

struct FirebaseAuthManager {
    static func signup(email: String, password: String, completionHandler: @escaping (Result<Bool?, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    static func login(email: String, password: String, completionHandler: @escaping (Result<Bool?, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(true))
            }
        }
    }
}

