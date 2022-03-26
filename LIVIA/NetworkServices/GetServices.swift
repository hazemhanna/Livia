
//
//  GetServices.swift
//  AfaqOnline
//
//  Created by MGoKu on 5/21/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

class GetServices {
    
    static let shared = GetServices()
    let token = Helper.getApiToken() ?? ""

    
    func getCategeory() -> Observable<CategoriesModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getCategories
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(CategoriesModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }

    
    func getSlider() -> Observable<SliderModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getSliders
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(SliderModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    
    func getProducts() -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getProducts
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }

    
    func getWishList() -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getWishlist
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
}
