//
//  ResetPasswordVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password_confirmation: UITextField!
     var user_type = ""
    var code = ""
    var emailV = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func confirm(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let email = self.email.text else {return}
        guard let password = self.password.text else {return}
        guard let password_confirmation = self.password_confirmation.text else {return}
    }
    
    private func validate() -> Bool {
        if self.email.text!.isEmpty || email.text != code {
            displayMessage(title: "", message: "Code is invalid".localized, status: .error, forController: self)
            return false
        } else if self.password.text!.isEmpty {
            displayMessage(title: "", message: "Enter new password".localized, status: .error, forController: self)
            return false
        } else if self.password_confirmation.text!.isEmpty {
            displayMessage(title: "", message: "Enter confirm password".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
