//
//  FavoriteCell.swift
//  Shanab
//
//  Created by Macbook on 3/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher
class FavoriteCell: UITableViewCell {
    var AddToCart: (() ->Void)? =  nil
    var RemoveFromeFavorite: (() ->Void)? = nil
    @IBOutlet weak var productImage: UIImageView!{
        
        didSet {
            
          //  productImage.layer.cornerRadius
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func config(name: String, details: String, imagePath: String , price : Double) {
        if (!imagePath.contains("http")) {
            guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
            print(imageURL)
            self.productImage.kf.setImage(with: imageURL)
        }  else if imagePath != "" {
            guard let imageURL = URL(string: imagePath) else { return }
            self.productImage.kf.setImage(with: imageURL)
            
        } else if imagePath != "" {
            
            self.productImage.image = #imageLiteral(resourceName: "shanab loading")
            
            
        }
        self.name.text = name
        self.details.text = details
        self.price.text = "\(price)"
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        AddToCart?()
    }
    
    @IBAction func RemoveFromeFavorite(_ sender: Any) {
        RemoveFromeFavorite?()
    }
}
