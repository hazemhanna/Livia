//
//  Authentication.swift
//  Livia
//
//  Created by MAC on 22/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

class Authentication {
    
    static let shared = Authentication()
    let token = Helper.getApiToken() ?? ""

    func postLogin(params: [String: Any]) -> Observable<LoginModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postLogin
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(LoginModel.self, from: response.data!)
                        if let data = loginData.user {
                            
                        Helper.saveApiToken(token: loginData.token ?? "", email: data.email ?? "",user_id: data.id ?? 0)
                        
                        }
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }//END of POST Login
    
    func postRegister(params: [String: Any]) -> Observable<RegisterModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postRegister
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(RegisterModel.self, from: response.data!)
                        if let data = loginData.user {
                        Helper.saveApiToken(token: loginData.token ?? "", email: data.email ?? "",user_id: data.id ?? 0)
                        }
                        observer.onNext(loginData)
                    } catch {
                        print(error)
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
    
    func updateProfile(params: [String: Any]) -> Observable<ProfileModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.updateProfile
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(ProfileModel.self, from: response.data!)
                        observer.onNext(jobsData)
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func postChangePassword(params: [String: Any]) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.updatePassword
            let headers = [
                "Authorization": "Bearer \(self.token)"
            ]
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let jobsData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
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
