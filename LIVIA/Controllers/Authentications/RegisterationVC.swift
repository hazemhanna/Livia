//
//  RegisterationVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class RegisterationVC: UIViewController {
  
    @IBOutlet weak var name: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var phone: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var address: CustomTextField!
    @IBOutlet weak var password_confirmation: CustomTextField!

    @IBOutlet weak var LogBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let name = name.text else {return}
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        guard let confirmation = password_confirmation.text else {return}
        guard var phone = phone.text else {return}
        guard var address = address.text else {return}

    }
    
    private func validate() ->Bool {
        if self.name.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your name".localized , status: .error, forController: self)
            return false
        }else if self.email.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your Email".localized, status: .error, forController: self)
            return false
        }else if self.password.text!.count < 6 {
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else if self.password_confirmation.text!.isEmpty {
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else if self.phone.text!.isEmpty {
            displayMessage(title: "", message: "Enter your phone number".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    

    @IBAction func login(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
}



