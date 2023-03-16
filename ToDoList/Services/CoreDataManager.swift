//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Indra on 3/15/23.
//

import UIKit

class CoreDataManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getItems() -> [TodoItem] {
        do {
            let items = try context.fetch(TodoItem.fetchRequest())
            return items
        } catch {
            
        }
        
        return []
    }
    
    func createItem(_ item: String, user: String) {
        let newItem = TodoItem(context: context)
        newItem.username = user
        newItem.todoItem = item
        newItem.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func editItem(item: TodoItem, newTodoItem: String) {
        item.todoItem = newTodoItem
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteItem(item: TodoItem) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            
        }
    }
}
