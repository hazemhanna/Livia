//
//  RestaurantCell.swift
//  Shanab
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class RestaurantCell: UITableViewCell {
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var staticLB: UILabel!
    @IBOutlet weak var feesLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var restaurantNameLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        staticLB.adjustsFontSizeToFitWidth = true
        staticLB.minimumScaleFactor = 0.5
        self.selectionStyle = .none

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func config(name: String, time: Int,  imagePath: String) {
        if imagePath != "" {
            guard let imageURL = URL(string: imagePath) else { return }
            self.restaurantImage.kf.setImage(with: imageURL)
        } else {
            self.restaurantImage.image = #imageLiteral(resourceName: "shanab loading")
        }
        
        self.restaurantNameLB.text = name
        
        self.timeLB.text = "\(time)"
    }
    
}
