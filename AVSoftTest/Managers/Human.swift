//
//  Human.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 08.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

enum Sex {
    case male
    case female
}

import Foundation
import RealmSwift

class Person: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var sex: String = ""
    @objc dynamic var nationality: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var image = Data()
    @objc dynamic var humanDescription = ""
    var persons = List<Person>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
