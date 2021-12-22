//
//  RefundOrderCell.swift
//  Shanab
//
//  Created by MAC on 10/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class RefundOrderCell: UITableViewCell {
    
    @IBOutlet weak var dateLble : UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!

    var goToDetails: (() ->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func config(desc: String ,name : String ,date: String ,orderId : Int) {
        
        dateLble.text = "date".localized + " " + date
        statusLbl.text = name
        descLbl.text = desc
        orderNumLbl.text = String(orderId)
        
    }
    
    
    @IBAction func orderDetails(_ sender: UIButton) {
         goToDetails?()
    }
    
    
}
