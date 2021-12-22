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
    
    @IBOutlet weak var resturantName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var followBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var statusLbl : UILabel!


    var goToDetails: (() ->Void)? = nil
    var FollowOrder:(() ->Void)? = nil
    var cancelOrder:(() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusLbl.text = "status".localized
        self.cancelBtn.setTitle("Cancel Order".localized, for: .normal)
    }
    
    func config( date: String, status: String, orderNumber: Int) {
        self.date.text = date
        self.status.text = status.localized
        self.orderNum.text = "\(orderNumber)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
   
    @IBAction func orderDetails(_ sender: UIButton) {
         goToDetails?()
    }
    
    @IBAction func orderFollwing(_ sender: UIButton) {
        FollowOrder?()
    }
    
    @IBAction func caancelOrder(_ sender: UIButton) {
        cancelOrder?()
    }
    
}
