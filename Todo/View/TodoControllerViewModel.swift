//
//  TodoControllerViewModel.swift
//  Todo
//
//  Created by Decagon on 1/11/22.
//

import Foundation
class TodoControllerViewModel {
    var todoList = DataService.shared.todoList
    
    var numberOfTodo: Int {
         let count = DataService.shared.todoList.count
        return count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return numberOfTodo
    }

    func cellForRowAt(indexPath: IndexPath) -> Todo {
        
        let row = indexPath.row
        let todo = DataService.shared.todoList[row]
        return todo
    }
}
