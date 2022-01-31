//
//  TodoControllerLayout.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import UIKit

class TodoViewControllerLayout: UIView {

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
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = self.frame
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray.withAlphaComponent(0.05)
        return tableView
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        return view
    }()
    
    let add = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
    
    let cancel = UIImage(systemName: "clear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
    
    private let fab: UIButton = {
        let fab = UIButton()
        fab.translatesAutoresizingMaskIntoConstraints = false
        fab.setTitleColor(.white, for: .normal)
        fab.layer.cornerRadius = 30
        fab.layer.masksToBounds = true
        fab.tintColor = .white
        fab.backgroundColor = .systemBlue
        
        return fab
    }()

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
        btn.setTitle("Create", for: .normal)
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

private var isBootomViewActive = false
    
    @objc func popUp() {
        if isBootomViewActive {
            
            for i in self.bottomView.constraints {
                self.bottomView.removeConstraint(i)
            }
            UIView.animate(withDuration: 0.3, animations: {
                
                self.bottomView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.layoutIfNeeded()
                self.fab.setImage(self.add, for: .normal)
                self.isBootomViewActive = false
               
            })
        } else {
            self.fab.setImage(self.add, for: .normal)
            for i in self.bottomView.constraints {
                self.bottomView.removeConstraint(i)
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomView.heightAnchor.constraint(equalToConstant: 430).isActive = true
                self.layoutIfNeeded()
                self.fab.setImage(self.cancel, for: .normal)
                self.isBootomViewActive = true
                
            })
    }
    
    }
    func resetAllTextField() {
        todoTitle.text = ""
        todoDescription.text = ""
        todoDateTime.text = ""
    }

    func setUpView() {
        fab.setImage(add, for: .normal)
        fab.addTarget(self, action: #selector(popUp), for: .touchUpInside)
        
        bottomView.addSubview(todoTitle)
        bottomView.addSubview(todoDescription)
        bottomView.addSubview(todoDateTime)
        bottomView.addSubview(saveButton)
    
        NSLayoutConstraint.activate([
            
            todoTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            
            todoTitle.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            todoTitle.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            
            todoDescription.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 20),
            
            todoDescription.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            todoDescription.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            
            todoDateTime.topAnchor.constraint(equalTo: todoDescription.bottomAnchor, constant: 20),
            
            todoDateTime.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            todoDateTime.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            
            saveButton.topAnchor.constraint(equalTo: todoDateTime.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        
        ])
    
        self.addSubviews(tableView, fab, bottomView)
        let layout = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layout.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: layout.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: layout.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: layout.bottomAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            fab.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -30),
            fab.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -20),
            fab.widthAnchor.constraint(equalToConstant: 60),
            fab.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
