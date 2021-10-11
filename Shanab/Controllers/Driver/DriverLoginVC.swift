//
//  DriverLoginVC.swift
//  Shanab
//
//  Created by Macbook on 5/17/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class DriverLoginVC: UIViewController {
    private let DriverLoginVCPresenter = DriverLoginPresenter(services: Services())
    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        DriverLoginVCPresenter.setDriverLoginViewDelegate(DriverLoginViewDelegate: self)
        
        
    }
    private func validate()-> Bool {
        if self.emailTF.text!.isEmpty {
            displayMessage(title: "", message: "ادخل البريد الالكتروني الخاص بك", status: .error, forController: self)
            return false
        } else if self.passwordTF.text!.isEmpty {
            displayMessage(title: "", message: "من فضلك ادخل الرقم السري الخاص بك", status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func LoginBN(_ sender: UIButton) {
        guard self .validate() else {return}
        guard var email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        
        if email.first == "0" {
            
            email.removeFirst()
        }
        
        let prefix = email.prefix(3)
        
        
        if prefix == "966" {
            
            email =  email.replacingOccurrences(of: prefix, with: "")
        }
        
        if email.first == "0" {
            
            email.removeFirst()
        }
//        
//        if email.contains("@") == false {
//            
//            
//            if email.contains("@") == false {
//                if email.first == "+" {
//                    
//                    email.remove(at: email.startIndex)
//                }
//
//                
//                let prefix = email.prefix(3)
//                
//                
//                if prefix != "966" {
//                    
//                    email = "966" + email
//                }
//            }
//        }
        
        DriverLoginVCPresenter.showIndicator()
        DriverLoginVCPresenter.postDriverLogin(email: email, password: password)
        
    }
    
    @IBAction func ForgetPassword(_ sender: UIButton) {
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        
        
               sb.modalPresentationStyle = .overCurrentContext
               sb.modalTransitionStyle = .crossDissolve
                sb.user_type = "driver"

               self.present(sb, animated: true, completion: nil)
    }
    @IBAction func registerBN(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "VerifyScreen") as? VerifyScreen else {return}
        
                sb.user = .agent
               self.navigationController?.pushViewController(sb, animated: true)
        
    }
}
extension DriverLoginVC: DriverLoginViewDelegate {
    func DriverLoginResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
            } else if resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
            } else if resultMsg.account != [""] {
                
                displayMessage(title: "", message: resultMsg.account[0], status: .error, forController: self)

                
            }
        }
    }
    
    
}
