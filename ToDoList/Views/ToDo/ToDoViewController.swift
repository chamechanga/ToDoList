//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Indra on 3/15/23.
//

import ReSwift

class ToDoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var todoItems: [TodoItem] = []
    private let currentUser: String = store.state.currentUserState.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        store.dispatch(GetTodoListAction(currentUser: currentUser))
        store.subscribe(self) {
            $0.select {
                $0.todoListState
            }
        }
    }
    
    private func setupView() {
        title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTodoItem))
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @objc
    private func addTodoItem() {
        showTodoItemAlert(title: "Add Item", message: "Enter new item") { [weak self] text in
            guard let `self` = self, let `text` = text else {
                return
            }
            
            store.dispatch(AddTodoItemAction(currentUser: self.currentUser, todoItem: text))
        }
    }
    
    private func showTodoItemAlert(title: String, message: String, _ completionHandler: @escaping (String?) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            completionHandler(alert.textFields?.first?.text)
        }))
        self.navigationController?.present(alert, animated: true)
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = todoItems[indexPath.row].todoItem
        cell?.detailTextLabel?.text = todoItems[indexPath.row].createdAt?.convertToString()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Items", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            self?.showTodoItemAlert(title: "Edit Item", message: "Enter new item") { [weak self] text in
                guard let `self` = self, let `text` = text else {
                    return
                }
                store.dispatch(EditTodoItemAction(currentUser: self.currentUser,
                                                  todoItem: self.todoItems[indexPath.row],
                                                  newTodoItem: text,
                                                  index: indexPath.row))
            }
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            guard let `self` = self else { return }
            let item = self.todoItems[indexPath.row]
            store.dispatch(DeleteTodoItemAction(currentUser: self.currentUser, todoItem: item))
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.navigationController?.present(alert, animated: true)
    }
}

extension ToDoViewController: StoreSubscriber {
    func newState(state: TodoListState) {
        self.todoItems = state.todo
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
