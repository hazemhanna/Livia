//
//  ReservationModel.swift
//  Shanab
//
//  Created by Macbook on 3/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import UIKit

class ReservationModel {
    var reservationNumber: Int
    var NumberSelected: Bool
    var numberId: String
   
    
    
    init(number: Int,id: String,  selected: Bool) {
        self.reservationNumber = number
        self.NumberSelected = selected
        self.numberId = id
       
    }
    
    init() {
        self.reservationNumber = 0
        self.NumberSelected = false
        self.numberId = ""
       
    }
}
