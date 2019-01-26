//
//  Category.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var color = UIColor.randomFlat.hexValue()

    // Realms has_many
    let items = List<Item>()
        
}
