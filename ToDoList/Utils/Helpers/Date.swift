//
//  Date.swift
//  ToDoList
//
//  Created by Indra on 3/15/23.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
