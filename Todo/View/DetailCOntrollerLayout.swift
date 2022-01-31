//
//  DetailCOntrollerLayout.swift
//  Todo
//
//  Created by Decagon on 1/11/22.
//

import UIKit

class DetailViewControllerLayout: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
                
    }
    override func layoutSubviews() {
        createDatePicker()
        setUpView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datePicker = UIDatePicker()
      
    var todoTitle: TextFieldLeftPadding = {
        var textField = TextFieldLeftPadding()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.autocorrectionType = .no
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        return textField
    }()
    
    var todoDescription: TextFieldLeftPadding = {
        var textField = TextFieldLeftPadding()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        textField.layer.cornerRadius = 10
        textField.placeholder =  "Description"
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        return textField
    }()
    
    var todoDateTime: TextFieldLeftPadding = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        var textField = TextFieldLeftPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = dateFormatter.string(from: Date())
        textField.autocorrectionType = .no
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    func dateFormat(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        return dateFormatter.string(from: from)
    }
    
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDone))
        toolBar.setItems([doneBtn], animated: true)
        return toolBar
    }
    @objc func onDone() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.todoDateTime.text = dateFormat(from: datePicker.date)
        self.endEditing(true)
    }
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        todoDateTime.textAlignment = .justified
        datePicker.datePickerMode = .date
        todoDateTime.inputView = datePicker
        todoDateTime.inputAccessoryView = createToolBar()
    }

    func resetAllTextField() {
        todoTitle.text = ""
        todoDescription.text = ""
        todoDateTime.text = ""
    }

    func setUpView() {
        self.addSubviews(todoTitle, todoDescription, todoDateTime, saveButton)
        
        let layout = self.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
            todoTitle.topAnchor.constraint(equalTo: layout.topAnchor, constant: 30),
            todoTitle.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 15),
            todoTitle.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -15),

            todoDescription.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 20),

            todoDescription.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 15),
            todoDescription.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -15),

            todoDateTime.topAnchor.constraint(equalTo: todoDescription.bottomAnchor, constant: 20),

            todoDateTime.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 15),
            todoDateTime.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -15),

            saveButton.topAnchor.constraint(equalTo: todoDateTime.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 60)

        ])
    }
}
