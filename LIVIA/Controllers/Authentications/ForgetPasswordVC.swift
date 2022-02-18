//
//  ForgetPasswordVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {


    @IBOutlet weak var email: UITextField!
    
    var code = ""
    var user_type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
