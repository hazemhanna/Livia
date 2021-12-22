//
//  ValiableResturantCell.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos
class ValiableResturantCell: UITableViewCell {
    var goToFavorites: (() ->Void)? = nil
    @IBOutlet weak var staticLB: UILabel!
    @IBOutlet weak var staticTime: UILabel!
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var price: UILabel!
    var isFavourite = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none

        staticLB.adjustsFontSizeToFitWidth = true
        staticLB.minimumScaleFactor = 0.5
        staticTime.adjustsFontSizeToFitWidth = true
        staticTime.minimumScaleFactor = 0.5
        resturantImage.setRounded()
        
        // Initialization code
    }
    
    @IBAction func AddToFavorite(_ sender: Any) {
       
        
        goToFavorites?()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(name: String, time: String, rate: Double, price: Double, imagePath: String, type: String) {
        if (!imagePath.contains("http")) {
                   guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
                             print(imageURL)
             self.resturantImage.kf.setImage(with: imageURL)
               }  else if imagePath != "" {
                   guard let imageURL = URL(string: imagePath) else { return }
            self.resturantImage.kf.setImage(with: imageURL)
              }
        
        self.name.text = name
        if "lang".localized == "ar" {
            self.price.text = "\(price) ريال|"
            self.time.text = "\(time )دقيقة"
            self.name.textAlignment = .right
            self.type.textAlignment = .right
        } else {
            self.price.text = "\(price)SAR|"
            self.time.text = "\(time )Min"
            self.name.textAlignment = .left
            self.type.textAlignment = .left
        }
        self.cosmos.rating = rate
        self.type.text = type
    }
    
}
