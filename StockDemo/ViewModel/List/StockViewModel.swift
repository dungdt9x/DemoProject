//
//  StockViewModel.swift
//  StockDemo
//
//  Created Do Trung Dung on 4/10/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Mohamad Kaakati
//  https://github.com/Kaakati/MVVM-Template-Generator
//

import Foundation

class StockViewModel : NSObject {
    private var apiService = APIService()
    var stocks : [StockModel]?
    var update: ((_ index: Int) -> ())?

    override init() {
        super.init()
        self.fetchStockList()
    }
    
    func fetchStockList() {
        let url = API.urlGetListStock
        self.apiService.fetchDataRxSwift(url: url, params: nil) { (result) in
            guard let arrays = result as? Array<[String: AnyObject]> else {
                self.stocks = DatabaseServices.sharedInstance.getStocks(index: 0)
                if (self.update != nil) {
                    self.update!(9)
                }
                return
            }
            
            arrays.forEach { (element) in
                if let stock = Stock(JSON: element) {
                    let xStock = StockModel(stock: stock)
                    let isExist = DatabaseServices.sharedInstance.checkExist(stock: xStock)
                    if (isExist == false) {
                        xStock.isFavourite = false
                        DatabaseServices.sharedInstance.insertStock(stock: xStock)
                    }
                }
            }
            self.stocks = DatabaseServices.sharedInstance.getStocks(index: 0)
            if (self.update != nil) {
                self.update!(9)
            }
        }
    }
    
    func loadMoreData(index: Int, completion: (_ index: Int, _ canLoadMore: Bool) -> ()) {
        let newArray = DatabaseServices.sharedInstance.getStocks(index: index)
        if (newArray.count == 0) {
            completion(index+9, false)
        } else {
            self.stocks?.append(contentsOf: newArray)
            completion(index+9, true)
        }
    }

}
