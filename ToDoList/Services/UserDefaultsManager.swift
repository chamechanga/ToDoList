//
//  UserDefaultsManager.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import Foundation


struct UserDefaultsManager {
    enum SessionKeys: String, CaseIterable {
        case currentUser = "com.save.currentUser"
        case users = "com.save.users"
    }
    
    private static let userDefault = UserDefaults.standard
    
    static func saveNew(username: String) {
        var users = getUsers()
        users.append(["username": username])
        userDefault.set(users, forKey: SessionKeys.users.rawValue)
        
    }
    
    static func getUsers() -> [[String: String]] {
        guard let users = userDefault.value(forKey: SessionKeys.users.rawValue) as? [[String : String]] else {
            return []
        }
        return users
    }
    
    static func setCurrentUser(_ username: String) {
        userDefault.set(username, forKey: SessionKeys.currentUser.rawValue)
        
    }
    
    static func getCurrentUser() -> String {
        guard let user = userDefault.value(forKey: SessionKeys.currentUser.rawValue) as? String else {
            return ""
        }
        return user
    }
}
