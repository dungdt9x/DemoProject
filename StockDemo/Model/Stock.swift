//
//  Stock.swift
//  StockDemo
//
//  Created Do Trung Dung on 4/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Mohamad Kaakati
//  https://github.com/Kaakati/MVVM-Template-Generator
//

import ObjectMapper

class Stock: Mappable {
    var name: String?
    var isFavourite: Bool?
    var symbol: String?
    var price: Double?
    var exchange: String?
    var image: String?
    var currency: String?
    var lastDiv: Double?
    var changes: Double?
    var industry: String?
    var sector: String?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        symbol <- map["symbol"]
        price <- map["price"]
        exchange <- map["exchange"]
        image <- map["image"]
        currency <- map["currency"]
        lastDiv <- map["lastDiv"]
        changes <- map["changes"]
        industry <- map["industry"]
        sector <- map["sector"]
    }
}
