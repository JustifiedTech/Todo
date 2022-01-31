//
//  DetailViewController.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import RealmSwift
import UIKit
class DetailViewController: UIViewController {
    var coordinator: Coordinator?
    lazy var todoId: String = ""
    private let viewLayout = DetailViewControllerLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.shared.fetchSpecific(todoId: todoId)
        title = "\(DataService.shared.todo?.title ?? "")"
        setValue(todo: DataService.shared.todo!)
        
    }
    
    override func viewDidLayoutSubviews() {
        setupLayoutConstraints()
    }
    
    func setValue(todo: Todo) {
        viewLayout.todoTitle.text = todo.title
        viewLayout.todoDescription.text = todo.details
        viewLayout.todoDateTime.text = todo.completedAt
        
    }
    
    @objc func save() {
        DataService.shared.fetchSpecific(todoId: todoId)
        let todo = DataService.shared.todo
        DataService.shared.updateData(todo: todo!,
                                    title: viewLayout.todoTitle.text ?? "",
                                    des: viewLayout.todoDescription.text ?? "details",
                                    date: viewLayout.todoDateTime.text ?? "")
        navigationController?.popViewController(animated: true)
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
