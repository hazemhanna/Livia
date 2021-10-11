//
//  MySbuscribtionsCell.swift
//  Shanab
//
//  Created by MAC on 27/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class MySbuscribtionsCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var resturantNameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var minumamPriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var packagePriceLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var favouritBtn: UIButton!

    @IBOutlet weak var staticminumamPriceLbl: UILabel!
    @IBOutlet weak var staticdeliveryPriceLbl: UILabel!
    @IBOutlet weak var staticdeliveryTimeLbl: UILabel!

    
    
    var goToFavorites: (() ->Void)? = nil
    var isFavourite = true
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func config(familyName: String, time: Int, productName: String, price: Double, rate: String,pakage : String , PackagePrice : Int) {
        
        self.resturantNameLbl.text = productName
        self.typeLbl.text = familyName
        if "lang".localized == "en" {
            self.deliveryTimeLbl.text = "\(time) Min"
            self.deliveryPriceLbl.text = "\(price) SAR"
            staticdeliveryTimeLbl.text = "Delivery Time"
            staticdeliveryPriceLbl.text = "Delivery price"
            staticminumamPriceLbl.text = "Minumam"
            packagePriceLbl.text = "\(PackagePrice) SAR"
        } else {
            self.deliveryTimeLbl.text = "\(time) دقيقة"
            self.deliveryPriceLbl.text = "\(price) ريال | "
            staticdeliveryTimeLbl.text = "وقت التوصيل"
            staticdeliveryPriceLbl.text = "مصاريف التوصيل"
            staticminumamPriceLbl.text = "الحد الادني"
            packagePriceLbl.text = "\(PackagePrice) ريال"

        }
        packageLbl.text = pakage
        self.rateLbl.text = rate
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favorite(_ sender: UIButton) {
        goToFavorites?()
        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
        } else {
            if isFavourite {
                isFavourite = false
            }
            else {
                isFavourite = true
            }
        }
    }
    
}
