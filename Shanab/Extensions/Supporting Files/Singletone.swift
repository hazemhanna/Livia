//
//  Singletone.swift
//  SevenArt
//
//  Created by D-TAG on 7/8/19.
//  Copyright © 2019 D-TAG. All rights reserved.
//

import Foundation
class Singletone: NSObject {
    static let instance = Singletone()
    
    public enum userType: String {
    
        case Customer = "customer"
        case Driver = "driver"
        case guest
        
    }
    
    var aboutApp = String()
    var conditions = String()
    var cart = [onlineCart]()
    var base_url = String()
    var appUserType : userType = .Customer
  
    
}
