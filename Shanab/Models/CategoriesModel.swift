//
//  CategoriesModel.swift
//  Shanab
//
//  Created by Macbook on 7/8/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
class CategoriesModel : Codable{
    var CategoeryName: String
    var NameSelected: Bool
    var TypeId: String

    
    
    init(name: String ,id: String,  selected: Bool) {
        self.CategoeryName = name
        self.NameSelected = selected
        self.TypeId = id

        
       
    }
    
    init() {
        self.CategoeryName = ""
        self.NameSelected = false
        self.TypeId = ""

       
    }
}
