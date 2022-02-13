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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 0.5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     func config(name: String, selected: Bool) {
         self.name.text = name
    }

    
}
