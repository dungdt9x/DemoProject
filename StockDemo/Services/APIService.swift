//
//  APIService.swift
//  StockDemo
//
//  Created by Do Trung Dung on 4/10/21.
//

import Foundation
import UIKit
import Alamofire
import RxAlamofire
import RxSwift

class APIService :  NSObject {
    static let sharedInstance = APIService()
    private let disposeBag = DisposeBag()

    func fetchData(url : String, params: [String: Any]?, completion: @escaping (_ result: Any) -> Void) {
        AF.request(url, method: .get, parameters: params).responseJSON { (response) in
            completion(response.value ?? "")
        }
    }
    
    func fetchDataRxSwift(url : String, params: [String: Any]?, completion: @escaping (_ result: Any) -> Void) {
        RxAlamofire.request(.get, url, parameters: params)
            .validate()
            .responseJSON()
            .subscribe(onNext: { (response) in
                completion(response.value ?? "")
            }, onError: { (error) in
                print("Error: ", error)
                completion("")
            }, onCompleted: {
                print("Complete")
            }, onDisposed: {
                print("Disposed")
            })
            .disposed(by: disposeBag)
    }
}
