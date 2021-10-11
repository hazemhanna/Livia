//
//  ProfileModel.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import UIKit
class ProfileModel {
    var ProfileName: String
    var ProfileSelected: Bool
    var profileId: String
    var profileImage: UIImage
    
    
    init(name: String,id: String, selected: Bool, profileImage: UIImage) {
        self.ProfileName = name
        self.ProfileSelected = selected
          self.profileImage = profileImage
        self.profileId = id
    }
    
    init() {
        self.ProfileName = ""
        self.ProfileSelected = false
        self.profileId = ""
         self.profileImage = UIImage()
    }
}
