//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Indra on 3/15/23.
//

import UIKit

class CoreDataManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getItems() -> [ToDo] {
        do {
            let items = try context.fetch(ToDo.fetchRequest())
            return items
        } catch {
            
        }
        
        return []
    }
    
    func createItem(_ item: String, user: String) {
        let newItem = ToDo(context: context)
        newItem.username = user
        newItem.todoItem = item
        newItem.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func editItem(item: ToDo, newTodoItem: String) {
        item.todoItem = newTodoItem
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteItem(item: ToDo) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            
        }
    }
}
