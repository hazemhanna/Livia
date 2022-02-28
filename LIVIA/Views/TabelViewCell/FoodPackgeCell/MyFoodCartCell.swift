//
//  MyFoodCartCell.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class MyFoodCartCell: UITableViewCell {

    var confirm:(() ->Void)? = nil

    var delete:(() ->Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func confirmBtn(_ sender: UIButton) {
        confirm?()
    }
  
    @IBAction func deleteBtn(_ sender: UIButton) {
        delete?()
    }
    
}
