//
//  User.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 01/06/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation

class UserModel {
    var name: String?
    var facultyID: Int?
    var groupNum: String?
    
    init(name: String, facultyID: Int, groupNum: String) {
        self.name = name
        self.facultyID = facultyID
        self.groupNum = groupNum
    }
}
