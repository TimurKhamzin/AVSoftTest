//
//  StoreManager.swift
//  AVSoftTest
//
//  Created by Timur Khamzin on 08.03.2020.
//  Copyright © 2020 Timur Khamzin. All rights reserved.
//

import Foundation
import RealmSwift

//подлкючение Realm
let realm = try! Realm()

class StorageManager {
    
    //функция добавления в базу данных
    func addToDB(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    // Функция удаления из базы данных
    func removeFromDB(object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    //Использование класа человек из файла Human.swift
    func addToPerson(person: Person){
        try! realm.write {
            person.persons.append(person)
        }
    }
}
