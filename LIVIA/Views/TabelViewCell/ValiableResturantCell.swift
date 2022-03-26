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
   
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantityTF: UILabel!

    @IBOutlet weak var contentStackView: UIStackView!

    var isFavourite = Bool()
    var goToFavorites: (() ->Void)? = nil
    
    var increase: (() ->Void)? = nil
    var decrease: (() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        if "lang".localized == "ar" {
            name.textAlignment = .left
            type.textAlignment = .left
        }else{
            name.textAlignment = .right
            type.textAlignment = .right
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(name: String,price: String, imagePath: String, type: String,isWishlist : Bool) {
        
        self.name.text = name
        self.type.text = type.parseHtml
       // self.isFavourite = isWishlist
        
        if "lang".localized == "ar" {
            self.price.text = "\(price) جنية"
            self.name.textAlignment = .right
            self.type.textAlignment = .right
        } else {
            self.price.text = "\(price) EGP"
            self.name.textAlignment = .left
            self.type.textAlignment = .left
        }
        
        if isWishlist{
            self.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
        }else{
            self.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
        }
        
      guard let imageURL = URL(string: (imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        self.resturantImage.kf.setImage(with: imageURL)
        
    }
    
    @IBAction func AddToFavorite(_ sender: Any) {
        goToFavorites?()
    }
    
    @IBAction func Increase(_ sender: UIButton) {
        increase?()
    }
    
    @IBAction func decreaseBN(_ sender: UIButton) {
        decrease?()
    }
    
}
