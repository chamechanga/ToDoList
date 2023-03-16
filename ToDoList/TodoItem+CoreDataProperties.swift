//
//  ToDo+CoreDataProperties.swift
//  
//
//  Created by Indra on 3/15/23.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var username: String?
    @NSManaged public var todoItem: String?
    @NSManaged public var createdAt: Date?

}
