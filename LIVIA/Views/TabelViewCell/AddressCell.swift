//
//  AddressCell.swift
//  Shanab
//
//  Created by Macbook on 5/4/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    @IBOutlet weak var addressTF: UILabel!
    @IBOutlet weak var deleteView: UIView!
    var delet:(() ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        deleteView.layer.cornerRadius = deleteView.frame.width/2
        deleteView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        deleteView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func config(address: String) {
        self.addressTF.text = address
    }
    
    @IBAction func deleteBn(_ sender: Any) {
         delet?()
    }
}
