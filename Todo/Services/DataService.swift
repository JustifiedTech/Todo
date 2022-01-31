//
//  DataService.swift
//  Todo
//
//  Created by Decagon on 1/11/22.
//

import Foundation
import RealmSwift

class DataService {
    static let shared = DataService()
    
    private let realm = try? Realm()
    
    var todoList = [Todo]()
    var todo: Todo?
    
    func saveData(_ todo: Todo) {
        realm?.beginWrite()
        realm?.add(todo)
        try? realm?.commitWrite()
    
    }
    
    func updateData(todo: Todo, title: String, des: String, date: String) {
        realm?.beginWrite()
        todo.title =  title
        todo.details = des
        todo.completedAt = date 
        realm?.add(todo, update: .modified)
        try? realm?.commitWrite()
        
    }
    
    func deleteData(todo: Todo) {
        realm?.beginWrite()
        realm?.delete(todo)
        try? realm?.commitWrite()
    
    }
    
    func fetchData() {
    todoList = realm?.objects(Todo.self).map({$0}) ?? []
    }
    
    func fetchSpecific(todoId: String) {
        todo = realm?.object(ofType: Todo.self, forPrimaryKey: todoId) ?? nil
    }
}
