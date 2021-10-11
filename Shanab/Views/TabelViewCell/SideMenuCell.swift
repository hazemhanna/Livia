//
//  SideMenuCell.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher
class SideMenuCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sideMenuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none

        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 0.5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
     func config(name: String, selected: Bool, imagePath: UIImage) {
            self.sideMenuImage.image = imagePath
            self.name.text = name
            if selected {
                self.name.backgroundColor = #colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1)
                self.name.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                self.name.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.name.textColor = #colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1)
            }
            
        }
        
    }

    

