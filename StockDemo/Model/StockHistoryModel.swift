//
//  StockHistoryModel.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import ObjectMapper

class StockHistoryModel: Mappable {
    var symbol: String?
    var historical: [HistoricalModel]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        symbol <- map["symbol"]
        historical <- map["historical"]
    }
}

class HistoricalModel: Mappable {
    var date: String?
    var open: Double?
    var high: Double?
    var low: Double?
    var close: Double?
    var adjClose: Double?
    var volume: Double?
    var change: Double?
    var changePercent: Double?
    var vwap: Double?
    var label: String?
    var changeOverTime: Double?
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        date <- map["date"]
        open <- map["open"]
        high <- map["high"]
        low <- map["low"]
        close <- map["close"]
        adjClose <- map["adjClose"]
        volume <- map["volume"]
        change <- map["change"]
        changePercent <- map["changePercent"]
        vwap <- map["vwap"]
        label <- map["label"]
        changeOverTime <- map["changeOverTime"]
    }

    
}


