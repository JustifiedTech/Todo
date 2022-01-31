//
//  TodoViewController.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    private let viewLayout = TodoViewControllerLayout()
    private let realm = try? Realm()
    var coordinator: Coordinator?
    private var viewModel = TodoControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo List"
        viewLayout.tableView.reloadData()
        setUpTableView()
        DataService.shared.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewLayout.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewDidLayoutSubviews() {
        setupLayoutConstraints()
        viewLayout.tableView.reloadData()
    }
    
    func setUpTableView() {
        viewLayout.tableView.dataSource = self
        viewLayout.tableView.delegate = self
        viewLayout.tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseIdentifier)
        viewLayout.tableView.separatorStyle = .none
    }
    
    func gotoDetailsPage(todo: String) {
        coordinator?.eventOccurred(with: .detail, todoId: todo)
    }
    
    @objc func save() {
        
        let todo = Todo()
        if let title = viewLayout.todoTitle.text, !title.isEmpty {
            todo.title = title
            
            todo.details = viewLayout.todoDescription.text ?? "details"
            todo.completedAt = viewLayout.todoDateTime.text ?? ""
            DataService.shared.saveData(todo)
            DataService.shared.fetchData()
            viewLayout.tableView.reloadData()
            viewLayout.resetAllTextField()
            viewLayout.popUp()
            
        } else {
            print("please add a title")
        }
        
    }
    
    fileprivate func setupLayoutConstraints() {
        viewLayout.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        view.addSubview(viewLayout)
        viewLayout.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([viewLayout.topAnchor.constraint(equalTo: view.topAnchor),
                                     viewLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     viewLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     viewLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
    }
}

extension TodoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTodo
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let todoCell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier, for: indexPath) as? TodoCell

        else {
            return UITableViewCell()
        }
        let todo = viewModel.cellForRowAt(indexPath: indexPath)
        todoCell.configure(with: todo)
        return todoCell
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let id = DataService.shared.todoList[row]._id
        gotoDetailsPage(todo: id)

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = indexPath.row
        let id = DataService.shared.todoList[row]._id
        let delete = UIContextualAction(style: .normal, title: "Delete") { [self] (_, _, completionHandler) in
            tableView.beginUpdates()
            guard let todo = realm?.object(ofType: Todo.self, forPrimaryKey: id)  else {
                return
            }
            DataService.shared.todoList.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DataService.shared.deleteData(todo: todo)
            tableView.endUpdates()
            completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
        
    }
    
}
