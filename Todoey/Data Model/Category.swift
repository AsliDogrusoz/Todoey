//
//  Category.swift
//  Todoey
//
//  Created by Asli Dogrusoz on 11/7/18.
//  Copyright © 2018 Asli Dogrusoz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
    
}
