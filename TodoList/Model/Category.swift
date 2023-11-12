//
//  Category.swift
//  TodoList
//
//  Created by 井本智博 on 2023/11/07.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
