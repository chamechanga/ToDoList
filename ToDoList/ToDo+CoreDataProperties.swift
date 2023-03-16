//
//  ToDo+CoreDataProperties.swift
//  
//
//  Created by Indra on 3/15/23.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var username: String?
    @NSManaged public var todoItem: String?
    @NSManaged public var createdAt: Date?

}
