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
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var customerAddress: UILabel!
     var goToDetails: (() ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        customerPic.setRounded()
    }
    func config(Name: String, imagePath: String, rate: Double, address: String) {
//        if (imagePath.contains("http")) {
//                   guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
//                   print(imageURL)
//                   self.customerPic.kf.setImage(with: imageURL)
//              if imagePath != "" {
//                   guard let imageURL = URL(string: imagePath) else { return }
//                   self.customerPic.kf.setImage(with: imageURL)
//               } else {
                self.customerPic.image = #imageLiteral(resourceName: "logo-1")
           //    }
        self.customerName.text = Name
        self.customerAddress.text = address
        self.rate.text = "\(rate)"
        if rate >= 0 {
            
            self.rate.rating = rate
        } else {
            
            self.rate.rating = 0

        }
       
    }

    @IBAction func goToDetails(_ sender: Any) {
        goToDetails?()
    }
}
