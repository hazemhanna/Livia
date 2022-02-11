//
//  ResetPasswordVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    private let UserChangePasswordVCPresenter = ChangePasswordPresenter(services: Services())
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password_confirmation: UITextField!
     var user_type = ""
        
        //Helper.getUserRole() ?? ""
    var code = ""
    var emailV = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(code)
        UserChangePasswordVCPresenter.setChangePasswordViewDelegate(ChangePasswordViewDelegate: self)
        
    }
    

    @IBAction func confirm(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let email = self.email.text else {return}
        guard let password = self.password.text else {return}
        guard let password_confirmation = self.password_confirmation.text else {return}
        if user_type == "customer" {
            UserChangePasswordVCPresenter.showIndicator()
                   UserChangePasswordVCPresenter.postUserChangePassword(email: emailV, password: password, password_confirmation: password_confirmation)
        } else {
            
            print(user_type)
            UserChangePasswordVCPresenter.showIndicator()
            UserChangePasswordVCPresenter.postDriverChangePassword(email: email, password: password, password_confirmation: password_confirmation)
        }
       
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
extension ResetPasswordVC: ChangePasswordViewDelegate {
    func DriverChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?) {
          if let resultMsg = result {
                  if resultMsg.successMessage != "" {
                    displayMessage(title: "", message: "Password changed".localized, status: .success, forController: self)
                    self.dismiss(animated: true, completion: nil)

                  } else if resultMsg.email != [""] {
                      displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
                  } else if resultMsg.password != [""] {
                      displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
                  } else if resultMsg.password_confirmation != [""] {
                      displayMessage(title: "", message: resultMsg.password_confirmation[0], status: .error, forController: self)
                  }
              }
    }
    
    func ChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
                self.dismiss(animated: true, completion: nil)
            } else if resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
            } else if resultMsg.password_confirmation != [""] {
                displayMessage(title: "", message: resultMsg.password_confirmation[0], status: .error, forController: self)
            }
        }
    }
    
    
}
