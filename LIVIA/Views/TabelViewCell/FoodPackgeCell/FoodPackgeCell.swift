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
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var validLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func config(imagePath: String ,date: String ,price: String, time: String,pakageName : String ) {
        packageLbl.text = pakageName
        validLbl.text = date
        PriceLbl.text = price + " " + "EGP".localized
        timeLbl.text = time
        guard let imageURL = URL(string: (imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
          self.resturantImage.kf.setImage(with: imageURL)
          
    }
    
}
