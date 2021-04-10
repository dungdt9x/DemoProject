//
//  CellViewModel.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import Schedule

class CellViewModel: NSObject {
    private let apiService = APIService()
    var bindCellViewModelToCell: ((_ state: Bool) -> ())?
    var stock : StockModel?
    private var plan: Task?
    
    init(stock: StockModel?) {
        super.init()
        if (stock != nil) {
            self.stock = stock
            if (stock?.image == nil || stock?.image.count == 0) {
                getAvatar()
            }
            if (plan == nil) {
                getRealTimePrice()
                plan = Plan.every(15.second).do {
                    self.getRealTimePrice()
                }
            }
        }
    }
    
    deinit {
        if (plan != nil) {
            plan?.removeAllActions()
            plan?.cancel()
        }
        plan = nil
    }
        
    func getAvatar() {
        let url = "\(API.urlProfileStock)/\(self.stock?.symbol ?? "")?apikey=\(API.APIKey)"
        self.apiService.fetchData(url: url, params: nil, completion: { (result) in
            guard let arrays = result as? Array<[String: AnyObject]> else {
                return
            }
            let data = arrays[0]
            let newStock = Stock(JSON: data)
            self.update(newStock: newStock)
        })
    }
    
    func getRealTimePrice() {
        if (plan == nil) {
            return
        }
        let url = "\(API.urlGetPriceUpdate)/\(self.stock?.symbol ?? "")?apikey=\(API.APIKey)"
        self.apiService.fetchData(url: url, params: nil) { [weak self] (result) in
            guard let arrays = result as? Array<[String: AnyObject]> else {
                self?.plan?.cancel()
                self?.plan?.removeAllActions()
                self?.plan = nil
                return
            }
            let data = arrays[0]
            let newStock = Stock(JSON: data)
            self?.update(newStock: newStock)
        }
    }
    
    func update(newStock: Stock?) {
        if (newStock != nil) {
            let newStockModel = StockModel(stock: newStock!)
            DatabaseServices.sharedInstance.updateStock(stock: newStockModel) { [weak self] (status) in
                if (self?.bindCellViewModelToCell != nil && self?.stock != nil) {
                    self?.bindCellViewModelToCell!(status)
                }
            }
        }
    }

    func updateFav() {
        if (self.stock != nil && bindCellViewModelToCell != nil) {
            DatabaseServices.sharedInstance.updateStockFav(stock: stock!) { [weak self] (result) in
                self?.bindCellViewModelToCell!(result)
            }
        }
    }

}

