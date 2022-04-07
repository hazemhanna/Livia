//
//  OrderReceiptCell.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class OrderReceiptCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        
    }
    
    func config(name: String, number: Int, price: String) {
        self.name.text = name
        self.price.text = price + "" + "EGP".localized
        quantity.text = "\(number)"
        
        if "lang".localized == "ar" {
            self.name.textAlignment = .right
        }else{
            self.name.textAlignment = .left
        }
    }
    
    
}
