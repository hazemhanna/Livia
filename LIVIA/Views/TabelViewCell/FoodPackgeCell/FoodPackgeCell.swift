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
    @IBOutlet weak var validLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(imagePath: String ,desc: String ,deliveryprice: Double, pakageTime: String,pakageName : String , PackagePrice : Int,valid : String,restaurant:String,creatAt : String) {
        
        
    }
    
}
