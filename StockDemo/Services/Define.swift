//
//  Define.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation

struct API {
    static let APIKey = "afacff496acf4e90bfe28573612b885d"
    static let BaseURL = "https://financialmodelingprep.com/api/v3"
    static let urlGetListStock = "\(BaseURL)/stock/list?apikey=\(APIKey)"
    static let urlGetPriceUpdate = "\(BaseURL)/quote-short"
    static let urlProfileStock = "\(BaseURL)/profile"
    static let urlGetHistory = "\(BaseURL)/historical-price-full"
}
