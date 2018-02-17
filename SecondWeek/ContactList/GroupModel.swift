//
//  GroupModel.swift
//  ContactList
//
//  Created by Stan on 2018-02-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class GroupModel: NSObject {
    var title = ""
    var info = [[String:Any]]()
    
    override init() {
        super.init()
    }
    
}

class PersonalModel: NSObject {
    var avatar = ""
    var Name = ""
    var Mobile = ""
    var Email = ""
    var Notes = ""
    
    override init() {
        super.init()
    }

}
