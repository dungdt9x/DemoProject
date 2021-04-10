//
//  Database.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import RealmSwift
import Realm

class DatabaseServices :  NSObject {
    static let sharedInstance = DatabaseServices()
    
    func insertStock(stock: StockModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(stock)
        }
    }
    
    func updateStockFav(stock: StockModel, completion: (_ state: Bool) -> ()) {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let stockIndex = stocks.firstIndex(where: {$0.symbol == stock.symbol}) ?? -1
        if (stockIndex >= 0) {
            let newStock = stocks[stockIndex]
            try! realm.write {
                newStock.isFavourite = !stock.isFavourite
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    func updateStock(stock: StockModel, completion: (_ state: Bool) -> ()) {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let stockIndex = stocks.firstIndex(where: {$0.symbol == stock.symbol}) ?? -1
        if (stockIndex >= 0) {
            let newStock = stocks[stockIndex]
            try! realm.write {
                newStock.image = stock.image
                newStock.currency = stock.currency
                newStock.price = stock.price
                newStock.changes = stock.changes
                newStock.lastDiv = stock.lastDiv
                newStock.exchange = stock.exchange
                newStock.sector = stock.sector
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    
    func getStocks(index: Int) -> [StockModel] {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        
        if (index + 9 <= stocks.count) {
            let result = stocks[index..<(index+9)]
            return Array(result)
        } else {
            return []
        }
    }
    
    func getFavStocks() -> [StockModel] {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let predicate = NSPredicate(format: "isFavourite == true")
        let favStocks = stocks.filter(predicate)
        return Array(favStocks)
    }
    
    func checkFav(stock: StockModel) -> Bool {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let predicate = NSPredicate(format: "isFavourite == true AND symbol == %@", stock.symbol)
        let isFavourite = stocks.filter(predicate)
        return isFavourite.count > 0  ? true : false
    }
    
    func checkExist(stock: StockModel) -> Bool {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let predicate = NSPredicate(format: "symbol == %@", stock.symbol)
        let isExist = stocks.filter(predicate)
        return isExist.count > 0  ? true : false
    }
    
    func removeFav(stock: StockModel) -> [StockModel] {
        let realm = try! Realm()
        let stocks = realm.objects(StockModel.self)
        let predicate = NSPredicate(format: "symbol == %@", stock.symbol)
        let favStocks = stocks.filter("isFavourite == true").filter(predicate)
        return Array(favStocks)
    }
    
    
    func getDarkModeState() -> Bool {
        let realm = try! Realm()
        let darkModes = realm.objects(Darkmode.self)
        if (darkModes.count == 0) {
            return false
        } else {
            return darkModes[0].isDark
        }
    }
    
    func saveDarkMode(state: Bool) {
        let realm = try! Realm()
        let darkModes = realm.objects(Darkmode.self)
        if (darkModes.count == 0) {
            let dark = Darkmode(state: state)
            try! realm.write {
                realm.add(dark)
            }
        } else {
            let darkMode = darkModes[0]
            try! realm.write {
                darkMode.isDark = state
            }
        }
    }
    
    
}
