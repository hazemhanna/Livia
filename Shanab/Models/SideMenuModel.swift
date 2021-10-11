//
//  SideMenuModel.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import UIKit


class SideMenuModel {
    var sideMenuName: String
    var sideMenuSelected: Bool
    var sideMenuId: String
    var sideMenuImage: UIImage
    
    
    init(name: String,id: String, selected: Bool, sideImage: UIImage) {
        self.sideMenuName = name
        self.sideMenuSelected = selected
          self.sideMenuImage = sideImage
        self.sideMenuId = id
    }
    
    init() {
        self.sideMenuName = ""
        self.sideMenuSelected = false
        self.sideMenuId = ""
         self.sideMenuImage = UIImage()
    }
}
