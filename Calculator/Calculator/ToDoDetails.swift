//
//  ToDoDetails.swift
//  Calculator
//
//  Created by David on 11.3.25..
//

import UIKit

protocol UpdateToDoItemDelegate {
    func updateToDoItem(item: ToDoItem, cellIndex: Int)
}

class ToDoDetails: UIViewController {
    
    var todoItem: ToDoItem!
    var delegate: UpdateToDoItemDelegate!
    var cellIndex: Int = 0
    
    init(todoItem: ToDoItem, cellIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.todoItem = todoItem
        self.cellIndex = cellIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    }
    
    @objc func editItem() {
        todoItemTitle.isEnabled = true
        todoItemTitle.borderStyle = .roundedRect
        
        todoItemDetails.isEnabled = true
        todoItemDetails.borderStyle = .roundedRect
        
        todoItemDueDate.isHidden = true
        datePicker.isHidden = false
        datePickerSwitch.isHidden = false
        
        // updateTodoButton.isEnabled = true
        updateTodoButton.isHidden = false
        updateTodoButton.backgroundColor = .blue
        
        
        
        navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    @objc func enableDatePicker() {
        datePicker.isEnabled = datePickerSwitch.isOn ? true : false
    }
    
    @objc func updateItem() {
        let title = todoItemTitle.text!
        let details = todoItemDetails.text ?? ""
        let date = datePicker.isEnabled ? datePicker.date : nil
        let todoItem = ToDoItem(title: title, description: details, untilDate: date)
        delegate.updateToDoItem(item: todoItem, cellIndex: cellIndex)
    }
    
    lazy var todoItemTitleLabel: UILabel = {
        let todoItemTitleLabel = UILabel()
        todoItemTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemTitleLabel.text = "To Do Title"
        todoItemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return todoItemTitleLabel
    }()
    
    lazy var todoItemTitle: UITextField = {
       let todoItemTitle = UITextField()
        todoItemTitle.text = todoItem.title
        todoItemTitle.autocorrectionType = .no
        todoItemTitle.isEnabled = false
        todoItemTitle.translatesAutoresizingMaskIntoConstraints = false
        return todoItemTitle
    }()
    
    lazy var todoItemDetailsLabel: UILabel = {
        let todoItemDetailsLabel = UILabel()
        todoItemDetailsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDetailsLabel.text = "To Do Details"
        todoItemDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDetailsLabel
    }()
    
    lazy var todoItemDetails: UITextField = {
        let todoItemDetails = UITextField()
        todoItemDetails.text = todoItem.description
        todoItemDetails.autocorrectionType = .no
        todoItemDetails.isEnabled = false
        todoItemDetails.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDetails
    }()
    
    lazy var todoItemDueDateLabel: UILabel = {
        let todoItemDueDateLabel = UILabel()
        todoItemDueDateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDueDateLabel.text = "Do until:"
        todoItemDueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDueDateLabel
    }()
    
    lazy var todoItemDueDate: UILabel = {
        let todoItemDueDate = UILabel()
        todoItemDueDate.text = todoItem.untilDate?.description
        todoItemDueDate.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDueDate
    }()
    
    lazy var datePickerSwitch: UISwitch = {
        let datePickerSwitch = UISwitch()
        datePickerSwitch.translatesAutoresizingMaskIntoConstraints = false
        datePickerSwitch.isHidden = true
        datePickerSwitch.addTarget(self, action: #selector(enableDatePicker), for: .valueChanged)
        return datePickerSwitch
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if let date = todoItem.untilDate {
            datePicker.date = date
        }
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isHidden = true
        datePicker.isEnabled = false
        return datePicker
    }()
    
    lazy var updateTodoButton: UIButton = {
        let updateTodoButton = UIButton()
        updateTodoButton.setTitle("Update", for: .normal)
        updateTodoButton.translatesAutoresizingMaskIntoConstraints = false
        updateTodoButton.backgroundColor = .gray
        updateTodoButton.layer.cornerRadius = 25
        updateTodoButton.addTarget(self, action: #selector(updateItem), for: .touchDown)
        // updateTodo.isEnabled = false
        updateTodoButton.isHidden = true
        return updateTodoButton
    }()
    

    
    func configureScreen() {
        view.backgroundColor = .white
        view.addSubview(todoItemTitleLabel)
        view.addSubview(todoItemTitle)
        
        view.addSubview(todoItemDetailsLabel)
        view.addSubview(todoItemDetails)
        
        view.addSubview(todoItemDueDateLabel)
        view.addSubview(todoItemDueDate)
        
        view.addSubview(datePicker)
        view.addSubview(datePickerSwitch)
        
        view.addSubview(updateTodoButton)
        
        NSLayoutConstraint.activate([
            todoItemTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            todoItemTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            todoItemTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            todoItemTitle.topAnchor.constraint(equalTo: todoItemTitleLabel.bottomAnchor, constant: 10),
            todoItemTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            todoItemTitle.heightAnchor.constraint(equalToConstant: 50),
            
            todoItemDetailsLabel.topAnchor.constraint(equalTo: todoItemTitle.bottomAnchor, constant: 30),
            todoItemDetailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemDetailsLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            todoItemDetailsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            todoItemDetails.topAnchor.constraint(equalTo: todoItemDetailsLabel.bottomAnchor, constant: 10),
            todoItemDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemDetails.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            todoItemDetails.heightAnchor.constraint(equalToConstant: 120),
            
            todoItemDueDateLabel.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 30),
            todoItemDueDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemDueDateLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            todoItemDueDateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            todoItemDueDate.topAnchor.constraint(equalTo: todoItemDueDateLabel.bottomAnchor, constant: 10),
            todoItemDueDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemDueDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            todoItemDueDate.heightAnchor.constraint(equalToConstant: 120),
            
            datePickerSwitch.topAnchor.constraint(equalTo: todoItemDueDateLabel.topAnchor, constant: 30),
            datePickerSwitch.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            datePickerSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePickerSwitch.widthAnchor.constraint(equalToConstant: 40),
            datePickerSwitch.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.topAnchor.constraint(equalTo: todoItemDueDateLabel.bottomAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalToConstant: view.frame.width),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            updateTodoButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            updateTodoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            updateTodoButton.widthAnchor.constraint(equalToConstant: 100),
            updateTodoButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
