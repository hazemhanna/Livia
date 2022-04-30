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
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var discountView  : UIView!

    
    var isFavourite = Bool()
    var goToFavorites: (() ->Void)? = nil
    var addToCart: (() ->Void)? = nil
    var increase: (() ->Void)? = nil
    var decrease: (() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func config(name: String,price: String, imagePath: String, type: String,isWishlist : Bool,discount : Double) {
        self.name.text = name
        self.type.text = type.parseHtml
        self.price.text = price + " " + "EGP".localized
        
        if discount == 0.00 {
            discountView.isHidden = true
        }else{
            discountView.isHidden = false
            self.discountLbl.text =  "discount".localized  +  " "  + String(Int(discount)) + "%"
        }
        
        if "lang".localized == "ar" {
            self.name.textAlignment = .right
            self.type.textAlignment = .right
        } else {
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
    
    func configCart(name: String,price: String, imagePath: String, type: String,quantity : Int,discount : Double) {
        
        self.name.text = name
        self.type.text = type.parseHtml
        self.quantityTF.text = "\(quantity)"
        
        if discount == 0.00 {
            discountView.isHidden = true
        }else{
            discountView.isHidden = false
            self.discountLbl.text =  "discount".localized  +  " "  + String(Int(discount)) + "%"
        }
        
        let p1 = Double(price) ?? 0
        let total =  Int(p1) * quantity
        self.price.text = String(total) + " " + "EGP".localized
        
        if "lang".localized == "ar" {
            self.name.textAlignment = .right
            self.type.textAlignment = .right
        } else {
            self.name.textAlignment = .left
            self.type.textAlignment = .left
        }
        
      self.FavoriteBN.setImage(UIImage(named: "remove"), for: .normal )
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
    
    @IBAction func addToCart(_ sender: UIButton) {
        addToCart?()
    }
    
    
}
