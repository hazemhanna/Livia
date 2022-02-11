//
//  ProductiveFamiliesCell.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
class ProductiveFamiliesCell: UITableViewCell {
    var addToFavorite: (() -> Void)? = nil
    @IBOutlet weak var staticLB: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var feesStatic: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var familyName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var isFavourite = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none

        productImage.setRounded()
        staticLB.adjustsFontSizeToFitWidth = true
        staticLB.minimumScaleFactor = 0.5
        feesStatic.adjustsFontSizeToFitWidth = true
        feesStatic.minimumScaleFactor = 0.5
        
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        if  Helper.getApiToken() == nil {
            
            addToFavorite?()

            
        } else {
            addToFavorite?()
            if isFavourite {
                FavoriteBN.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
                isFavourite = false
            }
            else {
                FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2"), for: .normal)
                isFavourite = true
                
            }
        }
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func config(familyName: String, time: Int, imagePath: String, productName: String, price: Double, rate: Double) {
        if (!imagePath.contains("http")) {
                   guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
                   print(imageURL)
                   self.productImage.kf.setImage(with: imageURL)
               }  else if imagePath != "" {
                   guard let imageURL = URL(string: imagePath) else { return }
                   self.productImage.kf.setImage(with: imageURL)
               } else {
                   self.productImage.image = #imageLiteral(resourceName: "shanab loading")
               }
        self.productName.text = productName
        self.familyName.text = familyName
        if "lang".localized == "en" {
            self.time.text = "\(time)Min"
            self.price.text = "\(price)SAR"
            staticLB.text = "Delivery Time"
            feesStatic.text = "Delivery Fees"
        } else {
            self.time.text = "\(time)دقيقة"
            self.price.text = "\(price)ريال | "
            staticLB.text = "وقت التوصيل"
            feesStatic.text = "مصاريف التوصيل"
        }
        
        self.cosmos.rating = rate
    }
    
}
