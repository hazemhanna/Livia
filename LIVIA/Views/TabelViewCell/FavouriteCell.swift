//
//  FavouriteCell.swift
//  Livia
//
//  Created by MAC on 20/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
import Kingfisher

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var price: UILabel!
    
    
    var AddToCart: (() ->Void)? =  nil
    var RemoveFromeFavorite: (() ->Void)? = nil
    var isFavourite  =  false

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if "lang".localized == "ar" {
            name.textAlignment = .right
            details.textAlignment = .right
            price.textAlignment = .right
        }else{
            name.textAlignment = .left
            details.textAlignment = .left
            price.textAlignment = .left
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func config(name: String,price: Double, imagePath: UIImage, type: String) {

          //if imagePath != "" {
          //  guard let imageURL = URL(string: imagePath) else { return }
        self.productImage.image = imagePath //.kf.setImage(with: imageURL)
           // }

        self.name.text = name
        self.details.text = type

        if "lang".localized == "ar" {
            self.price.text = "\(price) جنية"
            self.name.textAlignment = .right
            self.details.textAlignment = .right
        } else {
            self.price.text = "\(price) EGP"
            self.name.textAlignment = .left
            self.details.textAlignment = .left
        }
    }
    
    
    @IBAction func AddToCart(_ sender: Any) {
        AddToCart?()
    }
    
    @IBAction func RemoveFromeFavorite(_ sender: Any) {
        RemoveFromeFavorite?()
      
    }
    
    
}
