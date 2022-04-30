//
//  GetServices.swift
//  AboSleim
//
//  Created by MAC on 12/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

class GetServices {
    
    static let shared = GetServices()

    
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
                        print(error)
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
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    
    func getProducts() -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getProducts
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }

    
    func getWishList() -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getWishlist
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func getCart() -> Observable<CartModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getCart
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(CartModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
          return Disposables.create()
        }
    }
    
    
    func getOffers() -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getOffers
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }

    
    func getCategeoruProducts(id : Int) -> Observable<ProductModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getCategeoryProducts + "\(id)"
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProductModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func getProfile() -> Observable<ProfileModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getProfile
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProfileModel.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func getSetting() -> Observable<SettingModelJson> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.settings
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(SettingModelJson.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
    
    
    func getOrders() -> Observable<OrderModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getOrders
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(OrderModelJSON.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
          return Disposables.create()
        }
    }
    
    func getReservation() -> Observable<ReservationModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getReservation
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ReservationModelJSON.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
          return Disposables.create()
        }
    }
    
    func getNotification() -> Observable<NotificationModelJSON> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.getNotification
            let token = Helper.getApiToken() ?? ""

            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(NotificationModelJSON.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
          return Disposables.create()
        }
    }
    
}
