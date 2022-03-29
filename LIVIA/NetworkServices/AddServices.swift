//
//  AddServices.swift
//  Livia
//
//  Created by MAC on 22/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Alamofire
import RxSwift
import SwiftyJSON

struct AddServices {
    
    static let shared = AddServices()
    let token = Helper.getApiToken() ?? ""
    
    func addWishList(params: [String: Any],isWishList : Bool) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            var url = ""
            if isWishList {
                 url = ConfigURLs.removeWishlist
            }else{
                 url = ConfigURLs.addWishlist
            }
            
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END of POST Login
     
    func addToCart(params: [String: Any]) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.addToCart
           
            
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END of POST Login
    
    
    
    func updateCart(params: [String: Any]) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.updateCart
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END of POST Login
    
    func deleteCart(id: Int) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.deleteCart + "\(id)"
            
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            
            Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END of POST Login
}
