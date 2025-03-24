//
//  ToDoTableView.swift
//  Calculator
//
//  Created by David on 10.3.25..
//

import UIKit

class ToDoTableView: UITableViewController {
    var todoItems = [ToDoItem]()
    let emptyView = EmptyTodoList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureEmptyTodoList()
    }
    
    func setEmptyTodoListVisibility(_ visibility: Bool) {
        emptyView.isHidden = !visibility
    }
    
    func configureEmptyTodoList() {
        emptyView.isHidden = true
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 200),
            emptyView.widthAnchor.constraint(equalToConstant: 200)
        ])
        emptyView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureTable() {
        todoItems = DataManager.shared.loadData() ?? []
        if(todoItems.isEmpty) {
            setEmptyTodoListVisibility(true)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    @objc func addItem() {
        let vc = AddItemDetailsVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ToDoTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row].title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ToDoDetails(todoItem: todoItems[indexPath.row], cellIndex: indexPath.row)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DataManager.shared.saveData(inputData: todoItems)
            if(todoItems.isEmpty) {
                setEmptyTodoListVisibility(true)
            }
        }
    }
}

extension ToDoTableView : AddItemDetailsDelegate {
    func addToDoITem(todoItem: ToDoItem) {
        setEmptyTodoListVisibility(false)
        todoItems.append(todoItem)
        navigationController?.popViewController(animated: true)
        DataManager.shared.saveData(inputData: todoItems)
        tableView.reloadData()
    }
}















extension ToDoTableView: UpdateToDoItemDelegate {
    func updateToDoItem(item: ToDoItem, cellIndex: Int) {
        todoItems[cellIndex] = item
        navigationController?.popViewController(animated: true)
        DataManager.shared.saveData(inputData: todoItems)
        tableView.reloadData()
    }
}
