//
//  Services.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class Services {
    //MARK:- Get Adds
    func getAdds(item_id: Int, item_type: String ,completion: @escaping( _ error: Error?, _ result: [Add]?) -> Void){
        let url = ConfigURLs.getAdds
        let parameters = [
            "item_type": item_type,
            "item_id": item_id
        ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(GetAddsModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.adds {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- Get All Restaurants
    func getAllRestaurants(type: [String] ,completion: @escaping(_ error: Error?, _ restaurants: [Restaurant]?)->Void) {
        let url = ConfigURLs.getAllRestaurants
        
        let token = Helper.getApiToken() ?? ""

        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        let parameters = [
            "type": type
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value)
                print(json)
                do {
                    let restaurants = try
                        JSONDecoder().decode(AllRestaurantsModelJSON.self, from: response.data!)
                    if restaurants.status == true, let AllRestaurants = restaurants.data?.restaurants {
                        print(AllRestaurants)
                        completion(nil, AllRestaurants)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- post Restaurant Details
    func postRestaurantDetails(restaurant_id: Int, completion: @escaping(_ error: Error?, _ details: RestaurantDetail?)->Void) {
        let url = ConfigURLs.postRestaurantDetails
        let deviceToken = Helper.getDeviceToken() ?? ""
        let token = Helper.getApiToken() ?? ""
        let parameters = [
            "restaurant_id": restaurant_id
        ]
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        print(headers)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let details = try
                        JSONDecoder().decode(RestaurantDetailsModelJSON.self, from: response.data!)
                    if details.status == true, let restaurantDetails = details.data?.restaurantDetail {
                        print(restaurantDetails)
                        completion(nil, restaurantDetails)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                    
                }
            }
        
    }
    //MARK:- Get All Catgeories
    func getAllCatgeories(completion: @escaping(_ error: Error?, _ catgeories: [Category]?)->Void) {
        let url = ConfigURLs.getAllCatgeories
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value)
                print(json)
                do {
                    let catgeories = try
                        JSONDecoder().decode(AllCatgeoriesModelJSON.self, from: response.data!)
                    if catgeories.status == true, let allCatgeories = catgeories.data?.categories {
                        print(allCatgeories)
                        completion(nil, allCatgeories)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- Restaurant Meals
    func postRestaurantMeals(restaurant_id: Int, type: String, category_id: Int?, completion: @escaping( _ error: Error?, _ Meals: [RestaurantMeal]?)->Void) {
        let url = ConfigURLs.postRestaurantMeals
        
        
        var parameters : [String : Any] = [:]
        
        if category_id == -1 {
            
             parameters = [
                "restaurant_id": restaurant_id,
                "type": type
            ] as [String : Any]
            
        } else {
            
             parameters = [
                "restaurant_id": restaurant_id,
                "type": type,
                "category_id": category_id
            ] as [String : Any]
        }
        
        print(parameters)
        
      
        let device_token = Helper.getDeviceToken() ?? ""
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        print(headers)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let meaLs = try
                        JSONDecoder().decode(RestaurantMealsModelJSON.self, from: response.data!)
                    if meaLs.status == true, let restaurantMeals = meaLs.data?.restaurantMeals {
                        print(restaurantMeals)
                        completion(nil, restaurantMeals)
                    }
                }
                catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- get Settings
    func getSettings(completion: @escaping(_ error: Error?,  _ supporting: [Setting]?)->Void) {
        let url = ConfigURLs.getSettings
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let supporting = try
                        JSONDecoder().decode(SettingModelJSON.self, from: response.data!)
                    if supporting.status == true, let result = supporting.data?.settings {
                        print(result)
                        completion(nil, result)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
    }
    //MARK:- post Login
    func postLogin(email: String, password: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postLogin
        let parameters = [
            "email": email,
            "password": password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case.failure(let error):
                    completion(error, nil)
                case.success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "logged in successfully".localized
                        if let token = json["data"]["user"]["token"].string, let user_id = json["data"]["user"]["user_id"].int
                        
                        {
                            Singletone.instance.appUserType = .Customer
                            Helper.saveUserRole(role: Singletone.instance.appUserType.rawValue)
                            Helper.saveApiToken(token: token, email: email, user_id: user_id)
                            completion(nil, successMsg)
                        }
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.account = errorArr["account"] as? [String] ?? [""]
                        errorMsg.device_token = errorArr["device_token"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- post User Register
    func postUserRegister(name: String, email: String, password: String, phone: String, password_confirmation: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUserRegister
        let parameters = [
            "name": name,
            "email": email,
            "password": password,
            "phone": phone,
            "password_confirmation": password_confirmation
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "true"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.name = errorArr["name"] as? [String] ?? [""]
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.phone = errorArr["phone"] as? [String] ?? [""]
                        errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- User ChangePassword
    func postUserChangePassword(email: String, password: String, password_confirmation: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUserChangePassword
        let parameters = [
            "email": email,
            "password": password,
            "password_confirmation": password_confirmation
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "changed"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- User Profile Change Password
    func postUserProfileChangePassword(password: String, old_password: String, password_confirmation: String, completion: @escaping(_ error: Error?,_ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUserPostChangeProfilePassword
        let token = Helper.getApiToken() ?? ""
        let parameters = [
            "password": password,
            "old_password": old_password,
            "password_confirmation": password_confirmation
        ]
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "changed"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.old_password = errorArr["old_password"] as? [String] ?? [""]
                        errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
        
    }
    //MARK:- User Change Profile Image
    func UserChangeProfileImage(image: UIImage, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?, _ progress: Progress?)->Void) {
        let url = ConfigURLs.postChangeUserProfileImage
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.upload(multipartFormData: { (form:MultipartFormData) in
            if let data = image.jpegData(compressionQuality: 0.8) {
                form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to:  url, method: .post, headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let error):
                completion(error, nil, nil)
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    print("Uploading Image: \(progress.fractionCompleted)")
                    completion(nil, nil, progress)
                })
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    switch response.result {
                    case .failure(let error):
                        completion(error, nil, nil)
                    case .success(let value):
                        let json = JSON(value)
                        print("image updated \(json)")
                        if json["status"] == true {
                            let successMsg = SuccessError_Model()
                            successMsg.successMessage = json["message"].string ?? ""
                            completion(nil, successMsg, nil)
                        } else {
                            let errorMsg = SuccessError_Model()
                            guard let errorArr = json["data"]["errors"].dictionaryObject else {return}
                            errorMsg.image = errorArr["image"] as? [String] ?? [""]
                            completion(nil, errorMsg, nil)
                        }
                    }
                })
            }
        }
    }
    //MARK:- Get Code
    func postForgetPassword(email: String, completion: @escaping(_ error: Error?,_ message : SuccessError_Model?, _ result: Int?)->Void) {
        let url = ConfigURLs.postForgetPassword
        let parameters = [
            "email": email
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil , nil)
                case .success(let value):
                    let json = JSON(value)
                    
                    
                    do {
                        let code = try
                            JSONDecoder().decode(GetCodeModel.self, from: response.data!)
                        if code.status == true, let order_list = code.data {
                            print(order_list)
                            completion(nil, nil ,order_list.code)
                        } else if code.status == false {
                            let errorMsg = SuccessError_Model()
                            guard let errorArr = json["errors"].dictionaryObject else {return}
                            errorMsg.errorMessage = errorArr["error"] as? String ?? ""

                            completion(nil, errorMsg, nil )
                        }
                    } catch {
                        print(error)
                        completion(error, nil, nil)
                    }
//                    if json["status"] == true {
//                        let successMsg = SuccessError_Model()
//                        successMsg.successMessage = "true"
//                        completion(nil, successMsg)
//                    } else {
//                        let errorMsg = SuccessError_Model()
//                        guard let errorArr = json["errors"].dictionaryObject else {return}
//                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
//                        errorMsg.errorMessage = errorArr["error"] as? String ?? ""
//                        completion(nil, errorMsg)
//                    }
                }
            }
    }
    
    //MARK:- Set Token
    static func postUserSetToken(type: String, device_token: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUserSetToken
        let parameter = [
            "device_token": device_token,
            "type": type
        ]
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.device_token = errorArr["device_token"] as? [String] ?? [""]
                        errorMsg.type = errorArr["type"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Driver Get Code
    func postDriverGetCode(email: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverGetCode
        let parameter = [
            "email": email
        ]
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "true"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Driver Change Password
    func postDriverChangePassword(email: String, password: String, password_confirmation: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverChangePassword
        let parameter = [
            "email": email,
            "password": password,
            "password_confirmation": password_confirmation
        ]
        Alamofire.request(url, method: .post, parameters:parameter, encoding:  URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "changed"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
                
            }
        
    }
    //MARK:- Driver ChangePassword Profile
    func postDriverChangePasswordProfile(password: String, old_password: String, password_confirmation: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverChangePasswordProfile
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameter = [
            "password": password,
            "old_password": old_password,
            "password_confirmation": password_confirmation
        ]
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "changed"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.password = errorArr["password"] as? [String] ?? [""]
                        errorMsg.old_password = errorArr["old_password"] as? [String] ?? [""]
                        errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Driver Registrtion
    func postDriverRegistrtion(name: String, password: String, phone: String, password_confirmation: String,email: String, documents:  [UIImage], completion: @escaping(_ error: Error? , _  result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverRegistrtion
        let parameters = [
            "name": name,
            "password": password,
            "phone": phone,
            "password_confirmation": password_confirmation,
            "email": email,
        ]
        Alamofire.upload(multipartFormData: { (form :MultipartFormData) in
            
            for image in documents {
                if let data = image.jpegData(compressionQuality: 0.3) {
                    form.append(data, withName: "documents", fileName: "documents_images.jpeg", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in parameters {
                form.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post,headers: nil) { (result :SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let error):
                completion(error, nil)
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress { (progress :Progress) in
                    print(progress)
                } .responseJSON { (response :DataResponse<Any>) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                        completion(error, nil)
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        if json["status"] == true {
                            let successMsg = SuccessError_Model()
                            successMsg.successMessage = "Successful"
                            completion(nil, successMsg)
                        } else {
                            let errorMsg = SuccessError_Model()
                            guard let errorArr = json["errors"].dictionaryObject else {return}
                            errorMsg.name = errorArr["name"] as? [String] ?? [""]
                            errorMsg.phone = errorArr["phone"] as? [String] ?? [""]
                            errorMsg.password = errorArr["password"] as? [String] ?? [""]
                            errorMsg.password_confirmation = errorArr["password_confirmation"] as? [String] ?? [""]
                            errorMsg.email = errorArr["email"] as? [String] ?? [""]
                            completion(nil, errorMsg)
                        }
                        
                    }
                }
            }
        }
    }
    //MARK: Driver Login
    func postDriverLogin(email: String, password: String ,completion: @escaping( _ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverLogin
        let parameters = [
            "email": email,
            "password": password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "logged in successfully".localized
                        if let token = json["data"]["user"]["token"].string, let user_id = json["data"]["user"]["id"].int
                        {
                            Singletone.instance.appUserType = .Driver
                            Helper.saveUserRole(role: Singletone.instance.appUserType.rawValue)
                            Helper.saveApiToken(token: token, email: email, user_id: user_id)
                            completion(nil, successMsg)
                        }
                        } else {
                            let errorMsg = SuccessError_Model()
                            guard let errorArr = json["errors"].dictionaryObject else {return}
                            errorMsg.email = errorArr["email"] as? [String] ?? [""]
                            errorMsg.password = errorArr["password"] as? [String] ?? [""]
                            errorMsg.account = errorArr["account"] as? [String] ?? [""]
                            errorMsg.device_token = errorArr["device_token"] as? [String] ?? [""]
                            completion(nil, errorMsg)
                        }
                        
                    }
                }
            
    }
    //MARK: Driver Change Image
    func postDriverChangeImage(image: UIImage,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?, _ progress: Progress?)->Void){
        let url = ConfigURLs.postDriverChangeImage
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.upload(multipartFormData: { (form:MultipartFormData) in
            if let data = image.jpegData(compressionQuality: 0.8) {
                form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to:  url, method: .post, headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let error):
                completion(error, nil, nil)
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    print("Uploading Image: \(progress.fractionCompleted)")
                    completion(nil, nil, progress)
                })
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    switch response.result {
                    case .failure(let error):
                        completion(error, nil, nil)
                    case .success(let value):
                        let json = JSON(value)
                        print("image updated \(json)")
                        if json["status"] == true {
                            let successMsg = SuccessError_Model()
                            successMsg.successMessage = json["message"].string ?? ""
                            completion(nil, successMsg, nil)
                        } else {
                            let errorMsg = SuccessError_Model()
                            guard let errorArr = json["data"]["errors"].dictionaryObject else {return}
                            errorMsg.image = errorArr["image"] as? [String] ?? [""]
                            completion(nil, errorMsg, nil)
                        }
                    }
                })
            }
        }
        
    }
    //MARK:- post Is Available
    func getIsAvailable(completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.gettDriverIsAvailableChange
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    }
                }
            }
        
    }
    //MARK:- Driver Set Token
    static func postDriverSetToken(type: String, device_token: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverSetToken
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameters = [
            "type": type,
            "token": device_token
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.device_token = errorArr["device_token"] as? [String] ?? [""]
                        errorMsg.type = errorArr["type"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Driver Order List
    func getDriverOrderList(type: [String], currentPage : Int,completion: @escaping(_ error: Error?, _ result: OrderListPagination?,_ orderErrors: OrdersErrors?)->Void) {
        let url = ConfigURLs.getDriverOrderList
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameters : [String : Any] = [
            "type[]": type,
            "page":currentPage
        ]
        
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value )
                print(json)
                do {
                    let list = try
                        JSONDecoder().decode(DriverOrderListModelJSON.self, from: response.data!)
                    
                    
                    
                    if list.status == true, let order_list = list.data?.orders {
                        completion(nil, order_list, nil)
                    } else if list.status == false, let OrderErrors = list.errors {
                        print(OrderErrors.account ?? "")
                        completion(nil, nil, OrderErrors)
                    }
                } catch {
                    print(error)
                    completion(error, nil, nil)
                }
            }
    }
    //MARK:- Driver Order Details
    func postDriverOrderDetails(id: Int, completion: @escaping(_ error: Error?, _ details: [DriverOrder]?)->Void) {
        let url = ConfigURLs.getDriverOrderDetails
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameters = [
            "id": id
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let details = try
                        JSONDecoder().decode(DriverOrderDetalilsModelJSON.self, from: response.data!)
                    
                    if details.status == true, let order_details = details.data?.driverOrder {
                        print(order_details)
                        completion(nil, order_details)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                }
            }
        
    }
    //MARK:- post User Create Order
    func postUserCreateOrder(lat: Double, long: Double, quantity: Int, currency: String, total: Double, message: String, address_id: Int, cartItems: [createOrderModel], payment : String,type : String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUserCreateOrder
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
//        var cartItem = [[String: Any]]()
//        for item in cartItems {
//            var options = [[String:Any]]()
//            for option in item.optionsContainer ?? [] {
//                let addition = ["option_id" : option.id ?? 0]
//                options.append(addition)
//            }
//            let order = ["order" : [
//                "meal_id" : item.mealID ?? 0,
//                "option" :options,
//                "quantity": item.quantity ?? 0,
//                "message": item.message ?? ""
//            ]]
//            cartItem.append(order)
//        }
        
         print(String(describing: cartItems))
       print(modelToJSON(cartItems: cartItems))
        let parameters = [
            "lat": lat,
            "long": long,
            "quantity": quantity,
            "currency": currency,
            "total": total,
            "message": message,
            "cartItems":
                "[\(modelToJSON(cartItems: cartItems))]",
            "address_id": address_id,
            "payment_method":payment,
            "type":type
        ] as [String : Any]
        
        
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    print("error in create order:\(error)")
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.latitude = errorArr["lat"] as? [String] ?? [""]
                        errorMsg.longitude = errorArr["long"] as? [String] ?? [""]
                        errorMsg.currency = errorArr["currency"] as? [String] ?? [""]
                        errorMsg.quantity = errorArr["quantity"] as? [String] ?? [""]
                        errorMsg.total = errorArr["total"] as? [String] ?? [""]
                        errorMsg.message = errorArr["message"] as? [String] ?? [""]
                        errorMsg.cartItems = errorArr["cartItems"] as? [String] ?? [""]
                        print(errorMsg)
                        completion(nil, errorMsg)
                    }
                }
                
            }
        
        
        
    }
    

    func modelToJSON(cartItems:[createOrderModel]) -> String{
        var itemsArr:[Dictionary<String,Any>] = []
        
        var mealdict = ""
        for cartIndex in 0...cartItems.count - 1{
            var dict:[String:Any] = [:]
            
            let item = cartItems[cartIndex]
             mealdict = mealdict +  "{\"order\":{\"meal_id\": \(item.order.meal_id) ,\"quantity\":\(item.order.quantity) ,\"message\":\"\(item.order.message)\"}"
            
            if item.option.count != 0 {
                
                mealdict = mealdict + ",\"option\":["
            }
            
            for i in 0..<item.option.count {
                
                
                let j = item.option[i]
                mealdict = mealdict + "{\"option_id\":\(j.option_id),\"quantity\":\(j.quntity)"
                
                if i == item.option.count - 1 {
                    
                    mealdict = mealdict + "}]"
                } else {
                    
                    mealdict = mealdict + "},"

                }
            }
            
            if cartIndex == cartItems.count - 1 {
                
                mealdict = mealdict + "}"
                
            } else {
                
                mealdict = mealdict + "},"
            }
            
         
          //  dict["order"] = mealdict
            
           // itemsArr.append(dict)
        }
        print("JSON IS:\(mealdict)")
        //        for cartIndex in 0...cartItems.count - 1{
        //            let item = cartItems[cartIndex]
        //            string =  string + "{ \"order\":{ \"meal_id\":\(item.meal?.id ?? 0),\"quantity\":\(item.quantity ?? 0)"
        //
        //            if item.message != ""{
        //                string = string + ",\"message\":\(item.message ?? "")"
        //            }
        //            string = string + "}"
        //
        //            if let options = item.optionsContainer, options.count > 0{
        //                string = string + ",\"option\":["
        //                for index in 0...options.count - 1{
        //                    string = string + "{\"option_id:\(options[index].id!)}"
        //                    if index != options.count - 1{
        //                        string = string + ","
        //                    }
        //                }
        //                string = string + "]"
        //            }
        //
        //            string = string + "}"
        //            if cartIndex != cartItems.count - 1{
        //                string = string + ","
        //            }
        //        }
        return mealdict
    }
    
    //MARK: post Favorite Get
    func PostfavorieGet(item_type: String, completion: @escaping(_ error: Error?, _ favorits: [Favorites]?)->Void) {
        let url = ConfigURLs.postFavoriteGet
        let device_token = Helper.getDeviceToken() ?? ""
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameter = [
            "item_type": item_type
        ]
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value )
                print(json)
                do {
                    let favorites = try
                        JSONDecoder().decode(FavoritesModelJSON.self, from: response.data!)
                    if favorites.status == true, let favoriteList = favorites.data?.favorite {
                        print(favoriteList)
                        completion(nil, favoriteList)
                    }
                    
                } catch {
                    print(error)
                    completion(error, nil)
                }
            }
    }
    //MARK:- Get mail Template
    func GetmailTemplate(type: String, completion: @escaping(_ error: Error?, _ result:[Tempalte]? )->Void) {
        let url = ConfigURLs.getmailTemplate
        let parameters = [
            "type": type
        ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value )
                print(json)
                do {
                    let template = try
                        JSONDecoder().decode(MailTemplateModelJSON.self, from: response.data!)
                    if template.status == true, let mailTempale = template.data?.mail {
                        print(mailTempale)
                        completion(nil, mailTempale)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                    
                }
                
            }
        
    }
    //MARK:- post Create Reservation
    func postCreateReservation(restaurant_id: Int, number_of_persons: Int, date: String, time: String, price: Int,position : String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postCreateReservation
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameters = [
            "restaurant_id": restaurant_id,
            "number_of_persons": number_of_persons,
            "date": date,
            "time": time,
            "price": price,
            "position" : position
        ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.restaurant_id = errorArr["restaurant_id"] as? [String] ?? [""]
                        errorMsg.number_of_persons = errorArr["number_of_persons"] as? [String] ?? [""]
                        errorMsg.date  = errorArr["date"] as? [String] ?? [""]
                        errorMsg.time = errorArr["time"] as? [String] ?? [""]
                        errorMsg.price = errorArr["price"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                        
                    }
                }
                
            }
    }
    //MARK:- Get Reservations
    func postReservationsget(cancelation: Int, completion: @escaping( _ error: Error?, _ list: [reservationList]?)->Void) {
        let url = ConfigURLs.postgetReservations
        let parameters = [
            "cancelation": cancelation
        ]
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value)
                print(json)
                do {
                    let list = try
                        JSONDecoder().decode(ReservationListModelJSON.self, from: response.data!)
                    if list.status == true, let reservation_list = list.data?.reservation {
                        print(reservation_list)
                        completion(nil, reservation_list)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
                
            }
    }
    //MARK: post User Get Order
    func postUserGetOrder(status: [String], currentPage : Int,type : String ,completion: @escaping(_ error: Error?, _ list: orderpagination?)->Void) {
        let url = ConfigURLs.postUserGetOrder
        let parameters = [
            "status": status,
            "page":currentPage,
            "type":type
        ] as [String : Any]
        
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                do {
                    let list = try
                        JSONDecoder().decode(UserListModelJSON.self, from: response.data!)
                    if list.status == true, let UserList = list.data?.orders {
                        completion(nil, UserList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    //MARK: User Order Detail
    func postUserOrderDetail(id: Int, status: String, completion: @escaping(_ error: Error?, _ details: [DriverOrder]?)->Void) {
        let url = ConfigURLs.postUserOrderDetail
        let token = Helper.getApiToken() ?? ""
        let parameters = [
            "id": id,
            "status": status
        ] as [String : Any]
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value)
                print(json)
                do {
                    let details = try
                        JSONDecoder().decode(DriverOrderDetalilsModelJSON.self, from: response.data!)
                    
                    if details.status == true, let order_details = details.data?.userOrder {
                        print(order_details)
                        completion(nil, order_details)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                }
            }
    }
    //MARK:- Reservation Details
    func postReservationDetails(id: Int, completion: @escaping(_ error: Error?,_ details: DetailsDataClass?)->Void) {
        let url = ConfigURLs.postReservationDetails
        let parameters = [
            "id": id
        ]
        let token = Helper.getApiToken() ?? ""
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let details = try
                        JSONDecoder().decode(ReservationDetailstModelJSON.self, from: response.data!)
                    if details.status == true, let reservationDetails = details.data {
                        print(reservationDetails)
                        completion(nil, reservationDetails)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
        
    }
    //MARK:- Cancel Reservation
    func postCancelReservation(id: Int, completion: @escaping(_ error: Error?, _ reservation: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postCancelReservation
        let parameters = [
            "id": id
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = "done"
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.id = errorArr["id"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                        
                    }
                }
            }
    }
    //MARK:- Remove Favorite
    func postRemoveFavorite(item_id: Int, item_type: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postRemoveFavorite
        let parameters = [
            "item_id": item_id,
            "item_type": item_type
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.item_id = errorArr["item_id"] as? [String] ?? [""]
                        errorMsg.item_type = errorArr["item_type"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                        
                    }
                }
            }
    }
    //MARK: Create Favorite
    func postCreateFavorite(item_id: Int, item_type: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postCreateFavorite
        let parameters = [
            "item_id": item_id,
            "item_type": item_type
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.item_id = errorArr["item_id"] as? [String] ?? [""]
                        errorMsg.item_type = errorArr["item_type"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                        
                    }
                }
            }
    }
    //MARK:- Driver Change Order Status
    func postDriverChangeOrderStatus(id: Int , status : String, completion: @escaping( _ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverChangeOrderStatus
        let parameters : [String : Any] = [
            "id": id,
            "status" : status
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.id = errorArr["id"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
                
            }
    }
    //MARK:- get User Profile
    func getProfile(completion: @escaping (_ error: Error?, _ result: User?)->Void) {
        let url = ConfigURLs.getProfile
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let result = try
                        JSONDecoder().decode(GetProfileModelModelJSON.self, from: response.data!)
                    if result.status == true, let profileResult = result.data?.user {
                        print(profileResult)
                        completion(nil, profileResult)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
    }
    
    
    //MARK:- post Meal Search
    func postMealSearch(word: String, completion: @escaping( _ error: Error?, _ result: [CollectionDataClass]?)->Void) {
        let url = ConfigURLs.postMealSearch
        let parameters = [
            "word": word
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                //                let json = JSON(response.result.value as Any)
                //                               print(json)
                do {
                    let result = try
                        JSONDecoder().decode(MealSearchModelJSON.self, from: response.data!)
                    if result.status == true, let mealsResult = result.data?.searchResult {
                        print(mealsResult)
                        completion(nil, mealsResult)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //Mark: Search In Restaurants
    func postSearchRestauran(word: String, completion: @escaping( _ error: Error?, _ result: [SearchResult]?)->Void) {
        let url = ConfigURLs.postRestaurantSearch
        let parameters = [
            "word": word
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let result = try
                        JSONDecoder().decode(RestaurantSearchModelModelJSON.self, from: response.data!)
                    if result.status == true, let ResultResult = result.data?.searchResult {
                        print(ResultResult)
                        completion(nil, ResultResult)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
        
        
    }
    //MARK: User Edit Profile
    func postUserEditProfile(phone: String, name_ar: String, email: String, address : String, completion: @escaping(_ error : Error?, _ message: SuccessError_Model?, _ result: User?)->Void) {
        let url = ConfigURLs.postEditProfile
        let parameters = [
            "phone": phone,
            "name_ar": name_ar,
            "name_en": name_ar,
            "email": email,
            "address":address
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        
                        self.getProfile { (error, User) in
                            
                            if let err = error {
                                
                                completion(err,nil , nil)
                            } else {
                                
                                completion(nil,nil , User)

                            }
                        }
                        
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.phone = errorArr["phone"] as? [String] ?? [""]
                        errorMsg.name = errorArr["name_ar"] as? [String] ?? [""]
                        errorMsg.name = errorArr["name_en"] as? [String] ?? [""]
                        errorMsg.Address = errorArr["address"] as? [String] ?? [""]

                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        completion(nil, errorMsg , nil)
                        
                    }
                }
                
            }
    }
    //MARK:- post Driver Edit Profile
    func postDriverEditProfile(phone: String, name_ar: String, email: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postEditDriverProfile
        let parameters = [
            "phone": phone,
            "name_ar": name_ar,
            "email": email
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.phone = errorArr["phone"] as? [String] ?? [""]
                        errorMsg.name = errorArr["name"] as? [String] ?? [""]
                        errorMsg.email = errorArr["email"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                        
                    }
                }
            }
    }
    //MARK: get Driver Profile
    func getDriverProfile(completion: @escaping (_ error: Error?, _ result: User?)->Void) {
        let url = ConfigURLs.getProfile
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let result = try
                        JSONDecoder().decode(GetProfileModelModelJSON.self, from: response.data!)
                    if result.status == true, let profileResult = result.data?.user {
                        print(profileResult)
                        completion(nil, profileResult)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                }
            }
    }
    //MARK:- Meal Details
    func postMealDetails(meal_id: Int, Completion: @escaping(_ error: Error?, _ result: CollectionDataClass?)->Void) {
        let url = ConfigURLs.postMealDetails
        let parameters = [
            "meal_id": meal_id
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value)
                do {
                    let mealDetails = try JSONDecoder().decode(MealDetailsModelJSON.self, from: response.data!)
                    if mealDetails.status == true {
                      //  print(mealDetails.data)
                        Completion(nil, mealDetails.data)
                    }
                } catch {
                    print(error)
                    Completion(error, nil)
                    
                }
            }
    }
    //MARK:- get Addresses
    func getAddresses(completion: @escaping(_ error: Error?, _ addressList: [Address]?)->Void) {
        let url = ConfigURLs.getAddresses
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let addresses = try JSONDecoder().decode(AddressesListModelJSON.self, from: response.data!)
                    if addresses.status == true, let listOfAddress = addresses.data?.address {
                        print(listOfAddress)
                        completion(nil, listOfAddress)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- Add Address
    func postAddAddress(lat: Double, long: Double, address: String, floor: Int, country_id: Int, city_id: Int, area_id: Int, building: Int, apartment: Int, completion: @escaping(_ error: Error?, _ result: SuccessError_Model? )->Void) {
        let url = ConfigURLs.postAddAddress
        let parameters = [
            "lat": lat,
            "long": long,
            "address": address,
            "floor": floor,
            "country_id": country_id,
            "city_id": city_id,
            "area_id": area_id,
            "building": building,
            "apartment": apartment
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.latitude = errorArr["lat"] as? [String] ?? [""]
                        errorMsg.longitude = errorArr["long"] as? [String] ?? [""]
                        errorMsg.address = errorArr["address"] as? [String] ?? [""]
                        errorMsg.floor = errorArr["floor"] as? [String] ?? [""]
                        errorMsg.country_id = errorArr["country_id"] as? [String] ?? [""]
                        errorMsg.city_id = errorArr["city_id"] as? [String] ?? [""]
                        errorMsg.area_id = errorArr["area_id"] as? [String] ?? [""]
                        errorMsg.building = errorArr["building"] as? [String] ?? [""]
                        errorMsg.apartment = errorArr["apartment"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Get Cities
    func postGetCities(table: String, condition: String, id: Int, completion: @escaping( _ error: Error?, _ result: [Country]?)->Void) {
        let url = ConfigURLs.postGetCountries
        let parameters = [
            "table": table,
            "condition": condition,
            "id": id
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let countries = try JSONDecoder().decode(GetCountriesModelJSON.self, from: response.data!)
                    if countries.status == true, let result = countries.data?.countries {
                        print(result)
                        completion(nil, result)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
    }
    // MARK:- Get Cities And Aries
    func postGetCountries(table: String,  completion: @escaping( _ error: Error?, _ result: [Country]?)->Void) {
        let url = ConfigURLs.postGetCities
        let parameters = [
            "table": table,
            "condition": "null"
            ,
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let countries = try JSONDecoder().decode(GetCountriesModelJSON.self, from: response.data!)
                    if countries.status == true, let result = countries.data?.countries {
                        print(result)
                        completion(nil, result)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
    }
    //MARK:- Delete Address
    func postDeleteAddress(id: Int, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDeleteAddress
        let parameters = [
            "id": id
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.id = errorArr["id"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
                
            }
    }
    //MARK:-  Get Setting
    func getSetting(completion: @escaping(_ error: Error?, _ result: [Setting]?)->Void){
        let url = ConfigURLs.getSetting
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let setting = try JSONDecoder().decode(SettingModelJSON.self, from: response.data!)
                    if setting.status == true, let result = setting.data?.settings {
                        print(result)
                        completion(nil, result)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
        
    }
    //MARK:- Get Cart Items
    func getCartItems(completion: @escaping(_ error: Error?, _ result: OnlinetDataClass?)->Void) {
        let url = ConfigURLs.getCartItems
        let token = Helper.getApiToken() ?? ""
        let deviceToken = Helper.getDeviceToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : deviceToken]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let items = try JSONDecoder().decode(OnlineCartModelJSON.self, from: response.data!)
                    if items.status == true, let result = items.data {
                        print(result)
                        completion(nil, result)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK:- Add To Cart
    func postAddToCart(meal_id: Int, quantity: Int, message: String, options:  [(id:Int ,qun: Int)]?, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        
        var OptionString = ""
        print(options)
        var parameters : [String:Any]
        
        if let option = options {
            for i in 0..<option.count {
                
                
                if i == option.count - 1 {
                    
                    OptionString += "{\"option_id\":\(option[i].id),\"quantity\":\(option[i].qun)}"

                } else {
                    
                    OptionString += "{\"option_id\":\(option[i].id),\"quantity\":\(option[i].qun)},"

                }
            }
            
         OptionString = "[" + OptionString + "]"
             parameters = [
                "meal_id": meal_id,
                "quantity": quantity,
                "message": message,
                "options": OptionString
                    
                    //"{\"option_id\":\(1),\"quantity\":\(2)}"
            ] as [String : Any]
        } else {
            
            parameters = [
               "meal_id": meal_id,
               "quantity": quantity,
               "message": message
            ] as [String : Any]
        }
        
        print(OptionString)
        let url = ConfigURLs.postAddToCart
     
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.meal_id = errorArr["meal_id"] as? [String] ?? [""]
                        errorMsg.quantity = errorArr["quantity"] as? [String] ?? [""]
                        errorMsg.message = errorArr["message"] as? [String] ?? [""]
                        errorMsg.options = errorArr["options"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Delete Cart
    func postDeleteCart(condition: String, id: Int?, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDeleteCart
        
        var parameters : [String : Any]?
        
        if condition == "all" {
            
             parameters = [
                "condition": condition
            ]
        } else {
            
             parameters = [
                "id": id,
                "condition": condition
            ]
        }
        
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.condition = errorArr["condition"] as? [String] ?? [""]
                        errorMsg.id = errorArr["id"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
        
    }
    //MARK: Driver Delete Image
    func getDriverDeleteImage(completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.getDeleteImage
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    }
                }
            }
    }
    //MARK:- Update Quantity
    func postUpdateQuantity(meal_id: Int, quantity: Int, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postUpdateQuantity
        let token = Helper.getApiToken() ?? ""
        let parameters = [
            "meal_id": meal_id,
            "quantity": quantity
        ]
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.meal_id = errorArr["meal_id"] as? [String] ?? [""]
                        errorMsg.quantity = errorArr["quantity"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Driver Rejacted Order
    func posDriverRejactedOrder(order_id: Int, status : String , completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postDriverRejactedOrder
        let token = Helper.getApiToken() ?? ""
        let parameters :  [String : Any] = [
            "order_id": order_id,
            "status" : status
        ]
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                        
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.order_id = errorArr["order_id"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    // MARK: - Section Details
    func getMealsOfMainCategory(category_id: Int, completion: @escaping(_ error: Error?, _ result:[sectionMeal]? )->Void) {
        let url = ConfigURLs.getMealsOfMainCategory
        //let token = Helper.getApiToken() ?? ""
        let parameters = [
            "category_id": category_id
        ]
//        let headers = [
//            "token": token
//        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let Details = try JSONDecoder().decode(SectionDetailsJSONModel.self, from: response.data!)
                    if Details.status == true, let result = Details.data?.meals {
                        print(result)
                        completion(nil, result)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    //MARK: Rate Order
    func postRateOrder(order_id: Int, order_rate: Double , completion: @escaping(_ error: Error? , _ result: SuccessError_Model?)->Void ) {
        let url = ConfigURLs.postRateOrder
        let parameters : [String : Any] = [
            "order_id": order_id,
            "rate": order_rate
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.order_id = errorArr["order_id"] as? [String] ?? [""]
                        errorMsg.rate = errorArr["rate"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK:- Rate Driver
    func postRateDriver(order_id: Int, rate: Double, completion: @escaping(_ error: Error? , _ result: SuccessError_Model?)->Void ) {
        let url = ConfigURLs.postRateDriver
        let parameters : [String : Any] = [
            "order_id": order_id,
            "rate": rate
        ]
        let token = Helper.getApiToken() ?? ""
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.order_id = errorArr["order_id"] as? [String] ?? [""]
                        errorMsg.rate = errorArr["rate"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    //MARK: Rate Comment
    func postRateComment(order_id: Int, comment: String, completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void) {
        let url = ConfigURLs.postComment
        let token = Helper.getApiToken() ?? ""
        var FillComment = comment
        if FillComment == "" {
            
            FillComment = "No comment"
        }
        
        let parameters = [
            "order_id": order_id,
            "comment": FillComment
        ] as [String : Any]
       let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == true {
                        let successMsg = SuccessError_Model()
                        successMsg.successMessage = json["message"].string ?? ""
                        completion(nil, successMsg)
                    } else {
                        let errorMsg = SuccessError_Model()
                        guard let errorArr = json["errors"].dictionaryObject else {return}
                        errorMsg.order_id = errorArr["order_id"] as? [String] ?? [""]
                        errorMsg.rate = errorArr["rate"] as? [String] ?? [""]
                        completion(nil, errorMsg)
                    }
                }
            }
    }
    
    //MARK: Notification
    func getNotifications(completion: @escaping(_ error: Error?, _ result: [Notifications]?)->Void){
        
        
        let url = ConfigURLs.getNotifications
        let token = Helper.getApiToken() ?? ""

        let headers = token != "" ? [
             "token": token
         ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
         
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    do {
                        let Notifications = try
                            JSONDecoder().decode(NotificationModel.self, from: response.data!)
                        if Notifications.status == true, let Notification = Notifications.data?.notifications {
                            completion(nil, Notification)
                        }
                    } catch {
                        print(error)
                        completion(error, nil)
                        
                    }
            } 
        }
        
    }
        
}
    
    
    func getDriverNotifications(completion: @escaping(_ error: Error?, _ result: [Notifications]?)->Void){
        
       var url = String ()
        if Helper.getUserRole() ?? "" == "customer" {
            url = ConfigURLs.getNotifications
        }else{
            url = ConfigURLs.postDrivergetNotification
        }
        
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
             "token": token
         ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
         
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    do {
                        let Notifications = try
                            JSONDecoder().decode(NotificationModel.self, from: response.data!)
                        if Notifications.status == true, let Notification = Notifications.data?.notifications {
                            completion(nil, Notification)
                        }
                    } catch {
                        print(error)
                        completion(error, nil)
                        
                    }
            }
        }
        
    }
        
}
    
    func CreateEmail(message : String, name : String , phone : String , email : String , kind : String , Mailtype : String ,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void){
        
        
        let url = ConfigURLs.Createmail
        let token = Helper.getApiToken() ?? ""
        
        
        let parameter = [
            
            "name":name,
            "message":message,
            "phone":phone,
            "kind":kind,
            "type":Mailtype,
            "email":email
        
        ]

        let headers = token != "" ? [
             "token": token
         ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
         
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    let successMsg = SuccessError_Model()
                    successMsg.successMessage = "Message was sent".localized
                    completion(nil, successMsg)
                } else {
                    
                    let errorMsg = SuccessError_Model()
                    guard let errorArr = json["errors"].dictionaryObject else {return}
                    errorMsg.message = errorArr["message"] as? [String] ?? [""]
                    completion(nil, errorMsg)
                }
        }
        
    }
        
}
    
    
    func VerifyUserEmail(email : String ,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void){
        
        
        let url = ConfigURLs.VerifyUserEmail
        let token = Helper.getApiToken() ?? ""
        
        
        let parameter = [
            
            "email":email
        
        ]

        let headers = token != "" ? [
             "token": token
         ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
         
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    let successMsg = SuccessError_Model()
                    successMsg.successMessage = "Code was sent".localized
                    completion(nil, successMsg)
                } else {
                    
                    let errorMsg = SuccessError_Model()
                    guard let errorArr = json["errors"].dictionaryObject else {return}
                    errorMsg.email = errorArr["email"] as? [String] ?? [""]
                    completion(nil, errorMsg)
                }
        }
        
    }
        
}
    
    
    func VerifyDriverEmail(email : String ,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void){
        
        
        let url = ConfigURLs.VerifyDriverEmail
        let token = Helper.getApiToken() ?? ""
        
        
        let parameter = [
            
            "email":email
        
        ]

        let headers = token != "" ? [
             "token": token
         ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
         
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    let successMsg = SuccessError_Model()
                    successMsg.successMessage = "Code was sent".localized
                    completion(nil, successMsg)
                } else {
                    
                    let errorMsg = SuccessError_Model()
                    guard let errorArr = json["errors"].dictionaryObject else {return}
                    errorMsg.email = errorArr["email"] as? [String] ?? [""]
                    completion(nil, errorMsg)
                }
        }
        
    }
        
}
    
    
    func UserCode(code : String ,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void){
        
        
        let url = ConfigURLs.VerifyUserCode
        let token = Helper.getApiToken() ?? ""
        
        
        let parameter = [
            
            "code":code
        
        ]
         
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    let successMsg = SuccessError_Model()
                    successMsg.successMessage = "Code was sent".localized
                    completion(nil, successMsg)
                } else {
                    
                    let errorMsg = SuccessError_Model()
                    guard let errorArr = json["errors"].dictionaryObject else {return}
                    errorMsg.code = errorArr["code"] as? [String] ?? [""]
                    completion(nil, errorMsg)
                }
        }
        
    }
        
}
    
    
    func DriverCode(code : String ,completion: @escaping(_ error: Error?, _ result: SuccessError_Model?)->Void){
        
        
        let url = ConfigURLs.VerifyDriverCode
        let token = Helper.getApiToken() ?? ""
        
        
        let parameter = [
            
            "code":code
        
        ]
         
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if json["status"] == true {
                    
                    let successMsg = SuccessError_Model()
                    successMsg.successMessage = "Code was sent".localized
                    completion(nil, successMsg)
                } else {
                    
                    let errorMsg = SuccessError_Model()
                    guard let errorArr = json["errors"].dictionaryObject else {return}
                    errorMsg.code = errorArr["code"] as? [String] ?? [""]
                    completion(nil, errorMsg)
                }
        }
        
    }
}
 
    
    
    //MARK:- Get Adds
    func getSubscribtion(restaurant_id: Int ,completion: @escaping( _ error: Error?, _ result: [Subscription]?) -> Void){
        let url = "https://shnp.dtagdev.com/api/general/subscriptions"
        let parameters = [
            "restaurant_id": restaurant_id
        ] as [String : Any]
        
        let token = Helper.getApiToken() ?? ""
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(subscriptionModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.subscriptions {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
     
    //MARK:- Get Adds
    func getMySubscribtion(completion: @escaping( _ error: Error?, _ result: [SubscriptionElement]?) -> Void){
        let url = "https://shnp.dtagdev.com/api/user/subscriptions"
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(MySubscriptionsModelJason.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.subscriptions {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    
    //MARK:- post Create Reservation
    func applyingSubscribtion(restaurant_id: Int, subscription_id: Int,completion: @escaping(_ error: Error?, _ result: ApplyingSubscribtion?)->Void) {
        
        let url = "https://shnp.dtagdev.com/api/general/subscriptions/applying"
        // let url = ConfigURLs.postCreateReservation
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        let parameters = [
            "restaurant_id": restaurant_id,
            "subscription_id": subscription_id,
        ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let Adds = try
                        JSONDecoder().decode(ApplyingSubscribtionModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.subscription {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }

    }
    
    //MARK:- Get Adds
    func getFoodSub(restaurant_id: Int ,completion: @escaping( _ error: Error?, _ result: [FoodSubscription]?) -> Void){
        let url = "https://shnp.dtagdev.com/api/general/food-subscriptions"
        let token = Helper.getApiToken() ?? ""
        
        let parameters = [
            "restaurant_id": restaurant_id
        ] as [String : Any]
        
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(FoodPackegeModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.foodSubscriptions {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    
    func addFoodSubToCart(restaurant_id: Int ,food_subscription_id: Int ,has_delivery_subscription: Int ,delivery_price: Int ,food_price: Int ,total: Int ,completion: @escaping( _ error: Error?, _ result: AddFoodPackegeToCart?, _ message: String?) -> Void){
        let url = "https://shnp.dtagdev.com/api/general/food-subscriptions-cart/add"
        let token = Helper.getApiToken() ?? ""
        
        let parameters = [
            "restaurant_id": restaurant_id,
            "food_subscription_id": food_subscription_id,
            "has_delivery_subscription": has_delivery_subscription,
            "delivery_price": delivery_price,
            "food_price": food_price,
            "total": total,

        ] as [String : Any]
        
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let Adds = try JSONDecoder().decode(AddFoodPackegeToCartModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.foodCart {
                        completion(nil, AddsList, nil)
                    }else{
                        completion(nil, nil, "duplicated item".localized)
                    }
                } catch {
                    print(error)
                    completion(error, nil, nil)
                    
                }
            }
    }
    
    
    func deleteFoodSubCart(id: Int ,completion: @escaping( _ error: Error?, _ result: OrderPaymentModelJSON?) -> Void){
        let url = "https://shnp.dtagdev.com/api/user/food-subscriptions-cart/delete"
        
        let token = Helper.getApiToken() ?? ""
        let parameters = [
            "id": id,
        ] as [String : Any]
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let Adds = try JSONDecoder().decode(OrderPaymentModelJSON.self, from: response.data!)
                    if Adds.status == true {
                        completion(nil, Adds)
                    }
                } catch {
                    print(error)
                    completion(error, nil)
                    
                }
            }
    }
    
    //MARK:- Get Adds
    func getFoodSubCart(completion: @escaping( _ error: Error?, _ result: [FoodCart]?) -> Void){
        let url = "https://shnp.dtagdev.com/api/user/food-subscriptions-cart"
        let token = Helper.getApiToken() ?? ""
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(MyCartFoodSubscribtionModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.foodCarts {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    
    
    func applyFoodSub(restaurant_id: Int ,food_subscription_id: Int ,has_delivery_subscription: Int ,delivery_price: Double ,food_price: Double ,total: Int ,completion: @escaping( _ error: Error?, _ result: ApplyFoodPackege?) -> Void){
        let url = "https://shnp.dtagdev.com/api/general/food-subscriptions/applying"
        let token = Helper.getApiToken() ?? ""
        
        let parameters = [
            "restaurant_id": restaurant_id,
            "food_subscription_id": food_subscription_id,
            "has_delivery_subscription": has_delivery_subscription,
            "delivery_price": delivery_price,
            "food_price": food_price,
            "total": total,

        ] as [String : Any]
        
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(ApplyFoodPackegeModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.subscription {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    
    func getMyFoodSub(completion: @escaping( _ error: Error?, _ result: [MyFoodSubscribtion]?) -> Void){
        let url = "https://shnp.dtagdev.com/api/user/food-subscriptions"
        let token = Helper.getApiToken() ?? ""
        
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                print(json)
                do {
                    let Adds = try
                        JSONDecoder().decode(MyFoodSubscribtionModelJSON.self, from: response.data!)
                    if Adds.status == true, let AddsList = Adds.data?.subscriptions {
                        print(AddsList)
                        completion(nil, AddsList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                    
                }
            }
    }
    
    
    
    //MARK: post User Get Order
    func postUserGetRefusedOrder(status: [String],completion: @escaping(_ error: Error?, _ list: orderpagination?)->Void) {
        
        let url = "https://shnp.dtagdev.com/api/user/order/getOrder"
        
        let parameters = [
            "status": status,
        ] as [String : Any]
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                do {
                    let list = try
                        JSONDecoder().decode(UserListModelJSON.self, from: response.data!)
                    if list.status == true, let UserList = list.data?.orders {
                        completion(nil, UserList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    
    //MARK: post User Get Order
    func getUserRewards(completion: @escaping(_ error: Error?, _ list: [Reward]?)->Void) {
        let url = "https://shnp.dtagdev.com/api/user/rewards"
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                do {
                    let list = try
                        JSONDecoder().decode(RewardsModelJSON.self, from: response.data!)
                    if list.status == true, let UserList = list.data?.rewards {
                        completion(nil, UserList)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    
    func refundOrder(order_id : Int,rate : Double,refund_reson : String,completion: @escaping(_ error: Error?, _ list: RefundModelJSON?)->Void) {
        let url = "https://shnp.dtagdev.com/api/user/order/refund"
        
        let parameters = [
            "order_id": order_id,
            "rate": rate,
            "refund_reson": refund_reson,
        ] as [String : Any]
        
        
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                let json = JSON(response.result.value as Any)
                do {
                    let list = try
                        JSONDecoder().decode(RefundModelJSON.self, from: response.data!)
                    if list.status == true {
                        completion(nil, list)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    
    
    func checkOrderPayment(order_id : Int,completion: @escaping(_ error: Error?, _ list: OrderPaymentModelJSON?)->Void) {
        let url = "https://shnp.dtagdev.com/api/user/order/checkOrderPayment"
        
        let parameters = [
            "order_id": order_id,
        ] as [String : Any]
        
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let list = try JSONDecoder().decode(OrderPaymentModelJSON.self, from: response.data!)
                        completion(nil, list)
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    
    func paidOrder(order_id : Int,completion: @escaping(_ error: Error?, _ list: OrderPaymentModelJSON?)->Void) {
        let url = "https://shnp.dtagdev.com/api/user/order/payed"
        
        let parameters = [
            "order_id": order_id,
        ] as [String : Any]
        
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let list = try JSONDecoder().decode(OrderPaymentModelJSON.self, from: response.data!)
                        completion(nil, list)
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
  
    
    func getWebViewLink(order_id : Int,completion: @escaping(_ error: Error?, _ list: WebViewModel?)->Void) {
        let url = "http://shnp.dtagdev.com/api/user/order/get_code?order_id=\(order_id)"
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let list = try JSONDecoder().decode(WebViewModel.self, from: response.data!)
                        completion(nil, list)
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    
    func orderNumber(driver_id : Int,completion: @escaping(_ error: Error?, _ list: OrdersNumber?)->Void) {
        let url = "https://shnp.dtagdev.com/api/driver/ordersCount?driver_id=\(driver_id)"
        let token = Helper.getApiToken() ?? ""
        let headers = token != "" ? [
            "token": token
        ] : ["deviceToken" : "euh87f8AOkBqv65UGBT8Yi:APA91bFC9NVEbBSNNEo_oxh5VY9PpBAvTwK1ay304JKdeqcINc5WZ1OJQQKSEZ19m9R1GYiv_sAHbPfPLhtrdTOlYWgxXaG_ZCK3V8Iua5KGO5KtRg8hG9xwvcIkRO-oftJ1VxoeUOIy"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                do {
                    let list = try JSONDecoder().decode(OrdersNumber.self, from: response.data!)
                        completion(nil, list)
                } catch {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
            }
        
    }
    


    
    func RejectOrderFromDriver(order_id:Int , status : String) {
        let url = ConfigURLs.getDriverRejectOrder
        let token = Helper.getApiToken() ?? ""
    }
}
struct createOrderModel {
    let order : mealItems
    let option: [optionsInOrder]
}
struct mealItems{
    let meal_id: Int
    let quantity:Int
    let message:String
}
struct optionsInOrder{
    let option_id: Int
    let quntity : Int
}
