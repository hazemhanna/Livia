//
//  HeaderCell.swift
//  Shanab
//
//  Created by Macbook on 29/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
     var AddToFavorite:(() ->Void)? = nil
    @IBOutlet weak var mealName: UILabel!
    var isFavourite = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func config(mealName: String){
        self.mealName.text = mealName
    }
    
    @IBAction func AddToFavorite(_ sender: UIButton) {
        AddToFavorite?()
//        if isFavourite {
//                   FavoriteBN.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
//                   isFavourite = false
//               }
//               else {
//                   FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2"), for: .normal)
//                   isFavourite = true
//                   
//               }
    }
}
