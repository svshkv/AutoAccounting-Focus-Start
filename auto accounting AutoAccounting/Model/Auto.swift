//
//  Auto.swift
//  auto accounting AutoAccounting
//
//  Created by Саша Руцман on 09/10/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import RealmSwift

class Auto: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var year: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var logo: Int = 100
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, year: String, model: String, body: String, manufacturer: String, logo: Int = 100) {
        self.init()
        self.id = id
        self.year = year
        self.model = model
        self.body = body
        self.manufacturer = manufacturer
        self.logo = logo
    }
}
