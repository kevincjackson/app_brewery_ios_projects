//
//  Item.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var color = UIColor.randomFlat.hexValue()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
