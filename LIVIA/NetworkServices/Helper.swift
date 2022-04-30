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
     
    }
    
    class func saveApiToken(token: String, email: String, user_id: Int) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
        def.set(user_id, forKey: "user_id")
        def.set(email, forKey: "email")
        def.synchronize()
       // restartApp()
    }
    
    class func saveToken(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()

    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "token") as? String
        def.synchronize()

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
        def.removeObject(forKey: "token")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "user_id")
        def.removeObject(forKey: "email")
        def.synchronize()
    }
  
    class func getemail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    
    class func savedate(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "date")
        def.synchronize()
    }
    class func getdate() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "date") as? String
    }
    
    class func savetime(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "time")
        def.synchronize()
    }

    class func getTime() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "time") as? String
    }
    
}





