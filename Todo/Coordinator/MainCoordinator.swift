//
//  MainCoordinator.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import UIKit

class MainCoordinator: Coordinator { 
    var children: [Coordinator]?
    var navigationController: UINavigationController?  = UINavigationController()
    
    private let window: UIWindow
    
    init(window: UIWindow ) {
        self.window = window
    }
    
    func eventOccurred(with type: Event, todoId: String) {
        switch type {
        case .detail:
            let vc = DetailViewController()
            vc.todoId = todoId
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: false)
        case .todolist:
            let vc = TodoViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: false)
        }
    }

    func start() {
        let todoViewController = TodoViewController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        todoViewController.coordinator = self
        navigationController?.setViewControllers([todoViewController], animated: false)
    }

}
