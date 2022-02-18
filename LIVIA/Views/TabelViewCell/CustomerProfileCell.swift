//
//  CustomerProfileCell.swift
//  Shanab
//
//  Created by mac on 2/12/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//

import UIKit

class CustomerProfileCell: UITableViewCell {
    
    var Save:(() ->Void)? = nil
    var AddressMap : (() -> Void)? = nil
    
    @IBOutlet weak var Name: CustomTextField!
    
    @IBOutlet weak var Email: CustomTextField!
    
    @IBOutlet weak var Address: CustomButtons!
    
    @IBOutlet weak var Phone: CustomTextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    func config(name: String, email: String, address: String, phone: String) {
        self.Name.text = name
        self.Phone.text = phone
        self.Address.setTitle(address, for: .normal)
        self.Email.text = email
    }
    @IBAction func SaveBN(_ sender: Any) {
         Save?()
    }
    
    @IBAction func OpenMap(_ sender: UIButton) {
        
        AddressMap?()
    }
    
    
}
