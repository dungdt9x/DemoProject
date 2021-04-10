//
//  StockModel.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import Realm
import RealmSwift

class Darkmode: Object {
    @objc dynamic var isDark = false
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    convenience init(state: Bool) {
        self.init()
        self.isDark = state
    }
    
    override static func primaryKey() -> String? {
        return "_id"
    }

}
