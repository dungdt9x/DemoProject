//
//  FavouriteViewModel.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation

class FavouriteViewModel : NSObject {
    var update: (() -> ())?
    var stocks : [StockModel]? {
        didSet {
            if (self.update != nil) {
                self.update!()
            }
        }
    }

    override init() {
        super.init()
        self.loadData()
    }
    
    func loadData() {
        let newArray = DatabaseServices.sharedInstance.getFavStocks()
        if (newArray.count > 0) {
            self.stocks = newArray
        }
    }
    
    func removeStockFavFromList(stock: StockModel?) {
        if (stock == nil) {
            return
        }
        self.stocks = stocks?.filter({ $0.symbol != stock!.symbol})
    }

}
