//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Indra on 3/15/23.
//

import UIKit

class ToDoViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var todoItems: [ToDo] = []
    private let coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTodoItem))
        self.reloadTodoList()
    }
    
    @objc
    private func addTodoItem() {
        let alert = UIAlertController(title: "Add Item",
                                      message: "Enter new item",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit",
                                      style: .default,
                                      handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text else {
                return
            }
            
            self?.coreDataManager.createItem(text, user: "admin@admin.com")
            self?.reloadTodoList()
        }))
        self.navigationController?.present(alert, animated: true)
    }
    
    private func reloadTodoList() {
        self.todoItems = coreDataManager.getItems()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ToDoViewController: UITableViewDelegate {
    
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row].todoItem
        cell.detailTextLabel?.text = todoItems[indexPath.row].createdAt?.convertToString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Items", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item",
                                          message: "Enter new item",
                                          preferredStyle: .alert)
            alert.addTextField()
            alert.textFields?.first?.text = self.todoItems[indexPath.row].todoItem
            alert.addAction(UIAlertAction(title: "Submit",
                                          style: .default,
                                          handler: { [weak self] _ in
                guard
                    let field = alert.textFields?.first,
                    let text = field.text,
                    let item = self?.todoItems[indexPath.row]
                else {
                    return
                }
                
                self?.coreDataManager.editItem(item: item, newTodoItem: text)
                self?.reloadTodoList()
            }))
            self.navigationController?.present(alert, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            guard let item = self?.todoItems[indexPath.row] else {
                return
            }
            self?.coreDataManager.deleteItem(item: item)
            self?.reloadTodoList()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.navigationController?.present(alert, animated: true)
    }
}
