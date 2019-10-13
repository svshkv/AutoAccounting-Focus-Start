//
//  StorageManager.swift
//  auto accounting AutoAccounting
//
//  Created by Саша Руцман on 09/10/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static let logos = [#imageLiteral(resourceName: "Mitsubishi"), #imageLiteral(resourceName: "Renault"), #imageLiteral(resourceName: "Suzuki"), #imageLiteral(resourceName: "Opel") , #imageLiteral(resourceName: "Nissan"), #imageLiteral(resourceName: "Infiniti"), #imageLiteral(resourceName: "Mercury"), #imageLiteral(resourceName: "Volvo"), #imageLiteral(resourceName: "Jaguar"), #imageLiteral(resourceName: "Ssang_Yong"), #imageLiteral(resourceName: "GAZ") , #imageLiteral(resourceName: "Holden"), #imageLiteral(resourceName: "Audi"), #imageLiteral(resourceName: "Chevrolet"), #imageLiteral(resourceName: "Cadillac"), #imageLiteral(resourceName: "Bentley"), #imageLiteral(resourceName: "Honda"), #imageLiteral(resourceName: "BMW") , #imageLiteral(resourceName: "Mercedes"), #imageLiteral(resourceName: "Alfa_Romeo"), #imageLiteral(resourceName: "Peugeot"), #imageLiteral(resourceName: "Skoda"), #imageLiteral(resourceName: "Citroen"), #imageLiteral(resourceName: "Jeep"), #imageLiteral(resourceName: "Scion") , #imageLiteral(resourceName: "Toyota"), #imageLiteral(resourceName: "Maserati"), #imageLiteral(resourceName: "Vauxhall"), #imageLiteral(resourceName: "Bugatti"), #imageLiteral(resourceName: "Buick"), #imageLiteral(resourceName: "Mini"), #imageLiteral(resourceName: "Lancia") , #imageLiteral(resourceName: "Ford"), #imageLiteral(resourceName: "Rolls_Royce"), #imageLiteral(resourceName: "Hyundai"), #imageLiteral(resourceName: "Kia"), #imageLiteral(resourceName: "Dacia"), #imageLiteral(resourceName: "Dodge"), #imageLiteral(resourceName: "Land_Rover") , #imageLiteral(resourceName: "Chery"), #imageLiteral(resourceName: "Lamborghini"), #imageLiteral(resourceName: "Ferrari"), #imageLiteral(resourceName: "Lexus"), #imageLiteral(resourceName: "Saab"), #imageLiteral(resourceName: "Lada"), #imageLiteral(resourceName: "Seat") , #imageLiteral(resourceName: "Subaru")]
    
    static func saveObject(autoObject: Auto) {
        try! realm.write {
            realm.add(autoObject)
        }
    }
    
    static func deleteObject(autoObject: Auto) {
        try! realm.write {
            realm.delete(autoObject)
        }
    }
    
    static func deleteAllObjects() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func getData() -> [Auto] {
        
        return Array(realm.objects(Auto.self))
        
    }
    
}
