//
//  Item.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/23/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class Item {
    
    var title = ""
    var done = false
    
    init(_ title: String) {
        self.title = title
        self.done = false
    }
    
}
