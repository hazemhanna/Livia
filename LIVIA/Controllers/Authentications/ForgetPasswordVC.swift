//
//  ForgetPasswordVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {
    private let GetCodeVCPresenter = GetCodePresenter(services: Services())
    @IBOutlet weak var email: UITextField!
    
    var code = ""
    var user_type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCodeVCPresenter.setGetCodeViewDelegate(GetCodeViewDelegate: self)
    }
    
    @IBAction func send(_ sender: UIButton) {
        guard self.validate() else { return }
//
//        if email.text == "" {
//                    print("Enter either valid phone or email")
//        }else if let validphone = email.text, validphone.isPhone() || validphone.isValidEmail() {
//                    print("Enter either valid phone or email")
//                }else{
//
//                }
        
      
        
        guard var email = email.text else {return}
//
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
        GetCodeVCPresenter.showIndicator()
        GetCodeVCPresenter.ForgetPassword(email: email)
    }
    private func validate() -> Bool {
        if self.email.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your phone number".localized , status: .error, forController: self)
            return false
        } else {
            
            return true
        }
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ForgetPasswordVC: GetCodeViewDelegate {
    func ForgetPasswordResult(_ error: Error?, _ message: SuccessError_Model?, _ result : Int?) {
        if let code = result {
                
                displayMessage(title: "The code has been send".localized, message: "", status: .success, forController: self)
                
                let vc = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordVC") as!
                    ResetPasswordVC
                
                vc.code = "\(code)"
            vc.emailV = email.text ?? ""
            vc.user_type = user_type
            
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                
            
        }
        
        if let resultMsg = message {
             if !resultMsg.email.isEmpty, resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
                
            } else if resultMsg.errorMessage != "" {
                
                displayMessage(title: "", message: "User not found".localized, status: .error, forController: self)
            }
        }
    }
    
    
}
