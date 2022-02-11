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
    @IBOutlet weak var deliveryTimeLbl: UILabel!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var packagePriceLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var favouritBtn: UIButton!
    @IBOutlet weak var staticminumamPriceLbl: UILabel!
    @IBOutlet weak var staticdeliveryPriceLbl: UILabel!
    @IBOutlet weak var staticdeliveryTimeLbl: UILabel!

    
    @IBOutlet weak var ValidLbl: UILabel!
    @IBOutlet weak var ValidValueLbl: UILabel!
    
    var goToFavorites: (() ->Void)? = nil
    var isFavourite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func config(familyName: String, time: String, productName: String, minimum: Int, rate: String,pakage : String , PackagePrice : Int,Valid : String) {
        
        if "lang".localized == "en" {
           // self.deliveryPriceLbl.text = "\(price) SAR"
            staticdeliveryTimeLbl.text = "Valid From"
            staticdeliveryPriceLbl.text = "Delivery price"
            staticminumamPriceLbl.text = "Minumam"
            packagePriceLbl.text = "\(PackagePrice) SAR"
            ValidLbl.text = "Valid until"
            minumamPriceLbl.text = "\(minimum) SAR"

        }else{
           // self.deliveryPriceLbl.text = "\(price) ريال | "
            staticdeliveryTimeLbl.text = "سارية من"
            staticdeliveryPriceLbl.text = "مصاريف التوصيل"
            staticminumamPriceLbl.text = "الحد الادني"
            packagePriceLbl.text = "\(PackagePrice) ريال"
            ValidLbl.text = "سارية حتي"
            minumamPriceLbl.text = "\(minimum) ريال"

        }
        
        
        let fullNameArr = time.components(separatedBy: " ")
        self.deliveryTimeLbl.text = fullNameArr[0]
        self.packageLbl.text = pakage
        self.rateLbl.text = rate
        self.resturantNameLbl.text = productName
        self.typeLbl.text = familyName
        ValidValueLbl.text = Valid
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favorite(_ sender: UIButton) {
        goToFavorites?()
    }
    
}
