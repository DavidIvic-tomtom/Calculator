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
    var cellIndex: Int!
    
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
        todoItemDetails.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
    }
    
    // MARK: Objc functions
    @objc func editItem() {
        todoItemTitleLabel.isHidden = false
        todoItemTitle.isEnabled = true
        todoItemTitle.borderStyle = .roundedRect
        
        todoItemDetailsLabel.isHidden = false
        todoItemDetails.isEditable = true
        todoItemDetails.frame = CGRect(x: 20, y: 100, width: 300, height: 100)
        todoItemDetails.font = UIFont.systemFont(ofSize: 16)
        todoItemDetails.autocorrectionType = .no
        todoItemDetails.layer.borderWidth = 0.3
        todoItemDetails.layer.borderColor = UIColor.lightGray.cgColor
        todoItemDetails.layer.cornerRadius = 8
        
        todoItemDueDateLabel.isHidden = false
        todoItemDueDateEditLabel.isHidden = false
        todoItemDueDateLabel.isHidden = true
        todoItemDueDate.isHidden = true
        datePicker.isHidden = false
        datePickerSwitch.isHidden = false
        
        updateTodoButton.isHidden = false
        
        navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    @objc func enableDatePicker() {
        datePicker.isEnabled = datePickerSwitch.isOn ? true : false
        if (datePicker.isEnabled) {
            updateTodoButton.backgroundColor = .blue
            updateTodoButton.isEnabled = true
        }
        else {
            updateTodoButton.backgroundColor = .gray
            updateTodoButton.isEnabled = false
        }
    }
    
    @objc func shouldEnableUpdateButton() {
        
        updateTodoButton.isEnabled = todoItemTitle.text != todoItem.title 
                                    || todoItemDetails.text != todoItem.description
                                    // || todoItemDueDate != todoItem.untilDate
        
        updateTodoButton.backgroundColor = updateTodoButton.isEnabled ? .blue : .gray
    }
    
    @objc func updateItem() {
        let title = todoItemTitle.text!
        let details = todoItemDetails.text ?? ""
        let date = datePicker.isEnabled ? datePicker.date : nil
        let todoItem = ToDoItem(title: title, description: details, untilDate: date)
        delegate.updateToDoItem(item: todoItem, cellIndex: cellIndex)
    }
    
    // MARK: TodoItemTitle
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
        todoItemTitle.addTarget(self, action: #selector(shouldEnableUpdateButton),  for: .editingChanged)
        return todoItemTitle
    }()
    
    // MARK: TodoItemDetails
    lazy var todoItemDetailsLabel: UILabel = {
        let todoItemDetailsLabel = UILabel()
        todoItemDetailsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDetailsLabel.text = "To Do Details"
        todoItemDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        if (todoItem.description?.isEmpty == true) {
            todoItemDetailsLabel.isHidden = true
        }
            
        return todoItemDetailsLabel
    }()
    
    lazy var todoItemDetails: UITextView = {
        let todoItemDetails = UITextView()
        todoItemDetails.text = todoItem.description
        todoItemDetails.autocorrectionType = .no
        todoItemDetails.isEditable = false
        todoItemDetails.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDetails
    }()
    
    // MARK: TodoItemDate
    lazy var todoItemDueDateEditLabel: UILabel = {
        let todoItemDueDateEditLabel = UILabel()
        todoItemDueDateEditLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDueDateEditLabel.text = "Do until:"
        todoItemDueDateEditLabel.translatesAutoresizingMaskIntoConstraints = false
        todoItemDueDateEditLabel.isHidden = true
        return todoItemDueDateEditLabel
    }()
    
    lazy var todoItemDueDateLabel: UILabel = {
        let todoItemDueDateLabel = UILabel()
        todoItemDueDateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDueDateLabel.text = "Do until:"
        todoItemDueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        if (todoItem.untilDate == nil) {
            todoItemDueDateLabel.isHidden = true
        }
        return todoItemDueDateLabel
    }()
    
    lazy var todoItemDueDate: UILabel = {
        let todoItemDueDate = UILabel()
        todoItemDueDate.text = todoItem.untilDate?.extractDate()
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
        updateTodoButton.isEnabled = false
        updateTodoButton.isHidden = true
        return updateTodoButton
    }()
    

    // MARK: Functions
    func configureScreen() {
        view.backgroundColor = .white
        view.addSubview(todoItemTitleLabel)
        view.addSubview(todoItemTitle)
        
        view.addSubview(todoItemDetailsLabel)
        view.addSubview(todoItemDetails)
        
        view.addSubview(todoItemDueDateLabel)
        view.addSubview(todoItemDueDateEditLabel)
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
            todoItemDetails.heightAnchor.constraint(equalToConstant: 60),

            
            todoItemDueDate.topAnchor.constraint(equalTo: todoItemDueDateLabel.topAnchor),
            todoItemDueDate.leadingAnchor.constraint(equalTo: todoItemDueDateLabel.trailingAnchor, constant: 10),
            todoItemDueDate.heightAnchor.constraint(equalToConstant: 50),
            todoItemDueDate.widthAnchor.constraint(equalToConstant: 150),
            
            datePickerSwitch.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 20),
            datePickerSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datePickerSwitch.heightAnchor.constraint(equalToConstant: 50),
            
            todoItemDueDateEditLabel.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 20),
            todoItemDueDateEditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            todoItemDueDateEditLabel.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 30),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            updateTodoButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            updateTodoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateTodoButton.widthAnchor.constraint(equalToConstant: 100),
            updateTodoButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        if !todoItemDetails.text.isEmpty {
            NSLayoutConstraint.activate([
                todoItemDueDateLabel.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 20),
                todoItemDueDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                todoItemDueDateLabel.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
        else {
            NSLayoutConstraint.activate([
                todoItemDueDateLabel.topAnchor.constraint(equalTo: todoItemTitle.bottomAnchor, constant: 30),
                todoItemDueDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                todoItemDueDateLabel.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
        
    }
}

// MARK: Extensions
extension Date {
    func extractDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
}

extension ToDoDetails : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        shouldEnableUpdateButton()
        // adjustTextViewHeight()
    }
    
    func adjustTextViewHeight() {
        let size = todoItemDetails.sizeThatFits(CGSize(width: todoItemDetails.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        UIView.animate(withDuration: 0.2) {
            self.todoItemDetails.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.constant = size.height
                }
            }
            self.view.layoutIfNeeded()
        }
    }
}
