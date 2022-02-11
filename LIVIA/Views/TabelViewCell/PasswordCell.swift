//
//  PasswordCell.swift
//  Shanab
//
//  Created by mac on 2/12/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {
    var Save:(() ->Void)? = nil
    var strongPassword: (() ->Void)? = nil
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newPasswordConfirmationTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func strongPassword(_ sender: Any) {
        strongPassword?()
        
    }
    @IBAction func save(_ sender: Any) {
        Save?()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    func config(oldPassword: String, newPassword: String, confirmationPassword: String) {
        self.oldPasswordTF.text = oldPassword
        self.newPasswordTF.text = newPassword
        self.newPasswordConfirmationTF.text = confirmationPassword
    }
    
}
