//
//  Helper.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import MOLH
class Helper {
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        var vc = UIViewController()
        if let api_token = Helper.getApiToken() {
            print("api_token: \(api_token)")
            switch Helper.getUserRole() {
            case "customer":
                print("true")
//                Services.postUserSetToken(type: "ios", device_token: Helper.getDeviceToken() ?? "") { (error: Error?, result: SuccessError_Model?) in
//                    if let resultM = result {
//                        if resultM.successMessage != "" {
//                            let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
//                            window.rootViewController = sb
//                            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//                        }
//
//                    }
//                }
                    
            default:
                break
                
            }
        } else {
            vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
            Singletone.instance.appUserType = .Customer
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        
        
    }
    
    
    class func saveApiToken(token: String, email: String, user_id: Int) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
        def.set(user_id, forKey: "user_id")
        def.set(email, forKey: "email")
        def.synchronize()
        restartApp()
    }
    class func saveDeviceToken(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "device_token")
        
        def.synchronize()
    }
    
    class func getDeviceToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "device_token") as? String
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "token") as? String
    }
    
    class func saveUserRole(role: String) {
        let def = UserDefaults.standard
        def.setValue(role, forKey: "role")
    }
    class func getUserRole() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "role") as? String
    }
    
    class func LogOutUser() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "api_token")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "user_id")
        def.removeObject(forKey: "email")
        def.synchronize()
    }
    class func getuser_id() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? Int
    }
    class func getemail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    
}





