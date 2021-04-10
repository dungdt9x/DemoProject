//
//  StockModel.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import Realm
import RealmSwift

class StockModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var isFavourite = false
    @objc dynamic var symbol = ""
    @objc dynamic var price = 0.0
    @objc dynamic var exchange = ""
    @objc dynamic var image = ""
    @objc dynamic var currency = ""
    @objc dynamic var lastDiv = 0.0
    @objc dynamic var changes = 0.0
    @objc dynamic var industry = ""
    @objc dynamic var sector = ""

    convenience init(stock: Stock) {
        self.init()
        self.name = stock.name ?? ""
        self.isFavourite = stock.isFavourite ?? false
        self.symbol = stock.symbol ?? ""
        self.price = stock.price ??  0.0
        self.exchange = stock.exchange ?? ""
        self.image = stock.image ?? ""
        self.currency = stock.currency ?? ""
        self.lastDiv  = stock.lastDiv ?? 0.0
        self.changes = stock.changes ?? 0.0
        self.industry = stock.industry ?? ""
        self.sector = stock.sector ?? ""
    }
}
