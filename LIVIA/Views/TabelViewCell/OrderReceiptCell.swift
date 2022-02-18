//
//  OrderReceiptCell.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class OrderReceiptCell: UITableViewCell {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        
    }
    
    func config(name: String, number: Int, price: String , restaurant : String) {
        self.name.text = name
        self.number.text = "\(number)"
        print(price)
        self.price.text = price
    }
    
    
}
