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
    @IBOutlet weak var paidBtn : UIButton!
    @IBOutlet weak var paidLbl : UILabel!

    var pay : (() ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        paidBtn.setTitleColor(.white, for: .normal)
        paidLbl.text = "paid".localized
        self.paidBtn.setTitle("pay".localized, for: .normal)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(name: String, status:String,body:String,title:String){
        self.notificationName.text = name
        self.status.text = title
        let str =  body
        let arr = str.map { String($0) }
        
        if status == "order"  {
            if arr.count > 0 {
                if arr[12] ==  "1"{
                    if  arr[26] ==  "n" ||  arr[26] ==  "p"{
                        self.paidBtn.isHidden = true
                        self.paidLbl.isHidden = false
                    }else{
                        self.paidBtn.isHidden = true
                        self.paidLbl.isHidden = true
                    }
              
            }else if arr[12] ==  "0" || arr[12] ==  "2"{
                    self.paidBtn.isHidden = false
                    self.paidLbl.isHidden = true
            }else {
                self.paidBtn.isHidden = true
                self.paidLbl.isHidden = false
            }
            }else{
                self.paidBtn.isHidden = true
                self.paidLbl.isHidden = true
            }
        }else{
            self.paidBtn.isHidden = true
            self.paidLbl.isHidden = true
        }
    }

    @IBAction func payAction(_ sender: Any) {
        pay?()
    }
}
