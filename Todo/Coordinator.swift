//
//  Coordinator.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import Foundation

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children: [Coordinator]? {get set}
    
    func eventOccurred(with type: Event, todoId: String)
    func start()
}
