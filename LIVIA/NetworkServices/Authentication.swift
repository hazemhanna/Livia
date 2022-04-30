
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

    func postLogin(params: [String: Any]) -> Observable<LoginModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.postLogin
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { (response: DataResponse<Any>) in
                    do {
                        let loginData = try JSONDecoder().decode(LoginModel.self, from: response.data!)
                        Helper.saveApiToken(token: loginData.token ?? "", email: loginData.user?.email ?? "", user_id: loginData.user?.id ?? 0)
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
                        let def = UserDefaults.standard
                        def.set(loginData.token ?? "", forKey: "token")
                        def.synchronize()
                        
                        
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
            let token = Helper.getApiToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
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
            let token = Helper.getApiToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
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

    
    func updateAvatar(image: UIImage) -> Observable<BaseModel> {
        return Observable.create { (observer) -> Disposable in
            let url = ConfigURLs.updateAvatar
            let token = Helper.getApiToken() ?? ""
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
                if let data = image.jpegData(compressionQuality: 0.8) {
                    form.append(data, withName: "avatar", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
                    switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.uploadProgress { (progress) in
                      print("Image Uploading Progress: \(progress.fractionCompleted)")
                  }.responseJSON { (response: DataResponse<Any>) in
             do {
                    let registerData = try JSONDecoder().decode(BaseModel.self, from: response.data!)
                        observer.onNext(registerData)
                     } catch {
                         print(error)
                        observer.onError(error)
                    }
                  }
                }
             }
            return Disposables.create()
        }
    }//END of POST Register
    
    
}
