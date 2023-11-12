//
//  Item.swift
//  TodoList
//
//  Created by 井本智博 on 2023/11/07.
//

import Foundation
import RealmSwift
class Item : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var date: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
