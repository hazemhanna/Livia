//
//  FoodPackgeCell.swift
//  Shanab
//
//  Created by MAC on 08/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class FoodPackgeCell: UITableViewCell {

    @IBOutlet weak var resturantImage : UIImageView!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(imagePath: String ,desc: String ,deliveryprice: Double, pakageTime: String,pakageName : String , PackagePrice : Int) {
        if "lang".localized == "en" {
            self.deliveryPriceLbl.text = "\(deliveryprice) SAR Delivery price"
            PriceLbl.text = "\(PackagePrice) SAR"
        } else {
            self.deliveryPriceLbl.text = "\(deliveryprice) ريال اشتراك توصيل"
            PriceLbl.text = "\(PackagePrice) ريال سعودي"
        }
        packageLbl.text = pakageName
        self.timeLbl.text = pakageTime
        descLbl.text = desc
        guard let imageURL = URL(string: "https://shnp.dtagdev.com" + "/" + imagePath) else { return }
        self.resturantImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "shanab loading"))
    }
    
}
