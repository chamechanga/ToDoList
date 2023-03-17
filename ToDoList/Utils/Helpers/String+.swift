//
//  UIViewController.swift
//  ToDoList
//
//  Created by Indra on 3/16/23.
//

import UIKit

extension String {
    func getDateComponent(withFormat: String) -> DateComponents? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = withFormat
        if let date = dateformatter.date(from: self) {
            let calendar = Calendar.current
            let dateTime = calendar.dateComponents([.year, .day, .month, .hour, .minute], from: date)
            return dateTime
        }
        
        return nil
    }
}
