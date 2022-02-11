//
//  RestaurantDetailsCell.swift
//  Shanab
//
//  Created by Macbook on 4/16/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class RestaurantDetailsCell: UICollectionViewCell {
    @IBOutlet weak var nameLB: UILabel!
    var nameSelected = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(name: String, selected: Bool) {
        self.nameLB.text = name
        if selected {
            self.nameLB.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.nameLB.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            self.nameLB.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.nameLB.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    

}
