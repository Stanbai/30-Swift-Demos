//
//  Pet.swift
//  SearchBarInTableView
//
//  Created by Stan on 2018-03-07.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

enum PetType: String {
    case cat = "Cat"
    case dog = "Dog"
}
class Pet: NSObject {
    let name: String
    let imageName: String
    let category: PetType
    
    init(name: String, imageName: String, category: PetType) {
        self.name = name
        self.imageName = imageName
        self.category = category
    }
}
