//
//  ListCell.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {
    
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var detailstn : UIButton!
    
    var goToDetails: (() ->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    func config( date: String, status: String, orderNumber: Int) {
        
        self.date.text = date
        self.orderNum.text = "\(orderNumber)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
   
    @IBAction func orderDetails(_ sender: UIButton) {
         goToDetails?()
    }
    
   
    
}
