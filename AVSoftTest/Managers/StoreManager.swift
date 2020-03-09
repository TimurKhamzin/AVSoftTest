//
//  StoreManager.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 08.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    func addToDB(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func removeFromDB(object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func addDogToPerson(person: Person){
        try! realm.write {
            person.persons.append(person)
        }
    }
}
