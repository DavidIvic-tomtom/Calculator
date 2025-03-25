//
//  AddItemDetailsVC.swift
//  Calculator
//
//  Created by David on 12.3.25..
//

import UIKit

protocol AddItemDetailsDelegate {
    func addToDoITem(todoItem: ToDoItem)
}

class AddItemDetailsVC: UIViewController {
    
    var delegate: AddItemDetailsDelegate? = nil
    
    // MARK: Todo title
    lazy var todoItemTitleLabel: UILabel = {
        let todoItemTitleLabel = UILabel()
        todoItemTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemTitleLabel.text = "To Do Title"
        todoItemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return todoItemTitleLabel
    }()
    
    lazy var todoItemTitle: UITextField = {
        let todoItemTitle = UITextField()
    
        todoItemTitle.autocorrectionType = .no
        todoItemTitle.translatesAutoresizingMaskIntoConstraints = false
        
        todoItemTitle.borderStyle = .roundedRect
        todoItemTitle.placeholder = "Required"
        todoItemTitle.addTarget(self, action: #selector(enableSubmitButton), for: .editingChanged)
        
        
        return todoItemTitle
    }()
    
    // MARK: Todo Details
    lazy var todoItemDetailsLabel: UILabel = {
        let todoItemDetailsLabel = UILabel()
        todoItemDetailsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        todoItemDetailsLabel.text = "To Do Details"
        todoItemDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        return todoItemDetailsLabel
    }()
    
    lazy var todoItemDetails: UITextView = {
        let todoItemDetails = UITextView()
        todoItemDetails.frame = CGRect(x: 20, y: 100, width: 300, height: 100)
        todoItemDetails.font = UIFont.systemFont(ofSize: 16)
        todoItemDetails.translatesAutoresizingMaskIntoConstraints = false
        todoItemDetails.autocorrectionType = .no
        todoItemDetails.layer.borderWidth = 0.3
        todoItemDetails.layer.borderColor = UIColor.lightGray.cgColor
        todoItemDetails.layer.cornerRadius = 8
        return todoItemDetails
    }()
    
    // MARK: Date picker
    lazy var datePickerLabel: UILabel = {
        let datePickerLabel = UILabel()
        datePickerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        datePickerLabel.text = "Do until"
        datePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        return datePickerLabel
    }()
    
    lazy var datePickerSwitch: UISwitch = {
        let datePickerSwitch = UISwitch()
        datePickerSwitch.translatesAutoresizingMaskIntoConstraints = false
        datePickerSwitch.addTarget(self, action: #selector(enableDatePicker), for: .valueChanged)
        return datePickerSwitch
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isEnabled = false
        return datePicker
    }()
    
    // MARK: Submit button
    lazy var submitToDo: UIButton = {
        let submitToDo = UIButton()
        submitToDo.setTitle("Submit", for: .normal)
        submitToDo.translatesAutoresizingMaskIntoConstraints = false
        submitToDo.backgroundColor = .gray
        submitToDo.layer.cornerRadius = 25
        submitToDo.addTarget(self, action: #selector(submitItem), for: .touchDown)
        submitToDo.isEnabled = false
        return submitToDo
    }()
    
    // MARK: objc functions
    @objc func enableSubmitButton() {
        guard todoItemTitle.text?.isEmpty == false else {
            disableSubmitButton()
            return
        }
        submitToDo.backgroundColor = .blue
        submitToDo.isEnabled = true
    }
    
    @objc func enableDatePicker() {
        datePicker.isEnabled = datePickerSwitch.isOn ? true : false
    }
    
    @objc func submitItem() {
        let title = todoItemTitle.text!
        let details = todoItemDetails.text ?? ""
        let date = datePicker.isEnabled ? datePicker.date : nil
        let todoItem = ToDoItem(title: title, description: details, untilDate: date)
        delegate?.addToDoITem(todoItem: todoItem)
    }
    
    // MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureScreen()
    }
    
    func disableSubmitButton() {
        submitToDo.isEnabled = false
        submitToDo.backgroundColor = .gray
    }
    
    func configureScreen() {
        view.addSubview(todoItemTitleLabel)
        view.addSubview(todoItemTitle)
        
        view.addSubview(todoItemDetailsLabel)
        view.addSubview(todoItemDetails)
        
        
        view.addSubview(datePickerLabel)
        view.addSubview(datePickerSwitch)
        view.addSubview(datePicker)
        
        view.addSubview(submitToDo)
        
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
            
            datePickerLabel.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 30),
            datePickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePickerLabel.widthAnchor.constraint(equalToConstant: 100),
            datePickerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            datePickerSwitch.topAnchor.constraint(equalTo: todoItemDetails.bottomAnchor, constant: 40),
            datePickerSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePickerSwitch.widthAnchor.constraint(equalToConstant: 44),
            datePickerSwitch.heightAnchor.constraint(equalToConstant: 44),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalToConstant: view.frame.width),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            submitToDo.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 50),
            submitToDo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitToDo.widthAnchor.constraint(equalToConstant: 100),
            submitToDo.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}
