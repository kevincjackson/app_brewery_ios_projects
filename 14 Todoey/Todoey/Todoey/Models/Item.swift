//
//  Item.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/23/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class Item: Codable {
    
    var title: String = ""
    var done: Bool = false
    
    init(_ title: String) {
        self.title = title
        self.done = false
    }
    
}
