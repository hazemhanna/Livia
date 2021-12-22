//
//  AddToCartFoodPackgeCell.swift
//  Shanab
//
//  Created by MAC on 09/12/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//



import UIKit
class AddToCartFoodPackgeCell: UITableViewCell {

    @IBOutlet weak var resturantImage : UIImageView!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var addTCart : (() ->Void)? = nil

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(imagePath: String ,desc: String ,deliveryprice: Double, pakageTime: String,pakageName : String , PackagePrice : Int,valid : String) {
        if "lang".localized == "en" {
            PriceLbl.text = "\(PackagePrice) SAR"
        } else {
            PriceLbl.text = "\(PackagePrice) ريال سعودي"
        }
        packageLbl.text = pakageName
        self.timeLbl.text = pakageTime + " " + "days".localized
        descLbl.text = desc
        guard let imageURL = URL(string: "https://shnp.dtagdev.com" + "/" + imagePath) else { return }
        self.resturantImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "shanab loading"))
    }
   
    
    
    
    @IBAction func addToCartAction(_ sender: UIButton) {
         addTCart?()
    }
    
}
