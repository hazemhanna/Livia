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
    @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func config(name: String, status:String){
        self.notificationName.text = name
        self.status.text = status
    }
  
    
}
