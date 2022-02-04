//
//  DriverListCell.swift
//  Shanab
//
//  Created by Macbook on 6/21/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
class DriverListCell: UICollectionViewCell {
    @IBOutlet weak var customerPic: UIImageView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var customerAddress: UILabel!
    
     var goToDetails: (() ->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customerPic.setRounded()
    }
    
    func config(Name: String, imagePath: String, rate: Double, address: String, orderId : Int) {
        
        self.customerPic.image = #imageLiteral(resourceName: "logo-1")
        self.customerName.text = Name
        self.customerAddress.text = address
        if rate >= 0 {
            self.rate.rating = rate
        } else {
            self.rate.rating = 0
        }
       
        orderNumber.text = "order Number".localized + ": \(orderId)"
    }

    @IBAction func goToDetails(_ sender: Any) {
        goToDetails?()
    }
}
