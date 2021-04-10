//
//  DetailModelView.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation

class DetailStockViewModel : NSObject {
    private var apiService = APIService()
    var stock: StockModel?
    var update: ((_ status: Bool) -> ())?
    var stock3Months: [HistoricalModel]?
    var stock6Months: [HistoricalModel]?
    var stock1Year: [HistoricalModel]?
    var stock3Years: [HistoricalModel]?

    init(stock: StockModel) {
        super.init()
        self.stock = stock
    }
    
    func fetchStockListForTime(type: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let to = dateFormatter.string(from: Date())
        var fromDate = Date()
        var from = ""
        
        switch type {
        case 0:
            fromDate = Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date()
            break
        case 1:
            fromDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
            break
        case 2:
            fromDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
            break
        case 3:
            fromDate = Calendar.current.date(byAdding: .year, value: -3, to: Date()) ?? Date()
            break
        default:
            break
        }
        
        from = dateFormatter.string(from: fromDate)
        let url = "\(API.urlGetHistory)/\(self.stock?.symbol ?? "")?from=\(from)&to=\(to)&apikey=\(API.APIKey)"

        self.apiService.fetchDataRxSwift(url: url, params: nil) { [weak self] (result) in
            guard let object = result as? [String: Any] else {
                if (self?.update != nil) {
                    self?.update!(false)
                }
                return
            }
            let historyModel = StockHistoryModel(JSON: object)
            
            switch type {
            case 0:
                self?.stock3Months = historyModel?.historical
                break
            case 1:
                self?.stock6Months = historyModel?.historical
                break
            case 2:
                self?.stock1Year = historyModel?.historical
                break
            case 3:
                self?.stock3Years = historyModel?.historical
                break
            default:
                break
            }
            if (self?.update != nil) {
                self?.update!(true)
            }
        }
    }
}
