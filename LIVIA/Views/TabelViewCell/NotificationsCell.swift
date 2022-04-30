
//
//  NotificationsCell.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {
    
    @IBOutlet weak var notificationName: UILabel!
    @IBOutlet weak var orderstatus  : UILabel!
    @IBOutlet weak var ordersnumber : UILabel!

    var pay : (() ->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(id: Int,status: String,title: String) {
        self.orderstatus.text = status
        self.ordersnumber.text = "order Number".localized + " " + "\(id)"
        self.notificationName.text = title
    }

}
