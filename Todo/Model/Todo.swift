//
//  Todo.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var _id = UUID().uuidString
    @Persisted var title: String?
    @Persisted var details: String?
    @Persisted var completed: Bool = false
    @Persisted var createdAt: Date = Date()
    @Persisted var completedAt: String?
    override class func primaryKey() -> String? {
        "_id"
    }
}
