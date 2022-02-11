//
//  SubscriptionCell.swift
//  Shanab
//
//  Created by MAC on 26/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class SubscriptionCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func confic(price : String , title : String){
        titleLbl.text = title
        priceLbl.text = price + " " + "SAR".localized
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
