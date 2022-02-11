//
//  MyFoodCartCell.swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class MyFoodCartCell: UITableViewCell {
    
    @IBOutlet weak var resturantImage : UIImageView!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var totalLbl : UILabel!

    @IBOutlet weak var deliverStack : UIStackView!

    var confirm: (() ->Void)? = nil
    var delete : (() ->Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func config(imagePath: String ,desc: String ,deliveryprice: Double, pakageTime: String,pakageName : String , PackagePrice : Int, total : Double) {
      
        self.timeLbl.text = pakageTime
        self.deliveryPriceLbl.text = "\(deliveryprice) "
        PriceLbl.text = "\(PackagePrice) "
        packageLbl.text = pakageName
        self.timeLbl.text = pakageTime
        descLbl.text = desc
        self.totalLbl.text = "\(total)"
        
        if deliveryprice == 0{
            deliverStack.isHidden = true
        }else{
            deliverStack.isHidden = false
        }
        
        guard let imageURL = URL(string: "https://shnp.dtagdev.com" + "/" + imagePath) else { return }
        self.resturantImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "shanab loading"))
    }
    
    
    
    @IBAction func confirmBtn(_ sender: UIButton) {
        confirm?()
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        delete?()
    }
    
    
    
}
