//
//  File.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
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
