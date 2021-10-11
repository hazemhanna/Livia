//
//  VerifyCodeVC.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import SVProgressHUD

class VerifyCodeVC: UIViewController {
    
    var user : userType = .user

    @IBOutlet weak var Code: CustomTextField!
    
    @IBOutlet weak var ResendCode: UILabel!
    
    var presenter : SendCodePresenter?
    
    
    var counter = 120
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        presenter = SendCodePresenter(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Sendcode(_ sender: Any) {
        
        if Code.text == "" {
            
            displayMessage(title: "", message: "Enter verification code".localized, status: .error, forController: self)
        } else {
            
            presenter?.sendCode(code: Code.text ?? "", userType: user )
        }
        
    }
    
    
//    @objc func timerAction() {
//           counter -= 1
//
//        ResendCode.text = "Resend in ".localized + "\(counter)" + "second".localized
//       }
    

}

extension VerifyCodeVC : SendCodeView {
    func UserVerified(_ error: Error?, _ success: SuccessError_Model?) {
        
        if success?.successMessage != "" {
            
            displayMessage(title: "", message: "Account verified".localized, status: .success, forController: self)
            
             let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "RegisterationVC")
            
                   self.navigationController?.pushViewController(sb, animated: true)
            
        } else if success?.code != [""] {
            
            displayMessage(title: "", message: success?.code[0] ?? "", status: .error, forController: self)
        } else if error != nil {
            
            displayMessage(title: "", message: error?.localizedDescription ?? "", status: .error, forController: self)
        }
    }
    
    func DriverVerified(_ error: Error?, _ success: SuccessError_Model?) {
        
        if success?.successMessage != "" {
            
            displayMessage(title: "", message: "Account verified".localized, status: .success, forController: self)
            
            let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "AgentRegisterationVC")
           
                  self.navigationController?.pushViewController(sb, animated: true)
            
            
        } else if success?.code != [""] {
            
            displayMessage(title: "", message: success?.code[0] ?? "", status: .error, forController: self)
        } else if error != nil {
            
            displayMessage(title: "", message: error?.localizedDescription ?? "", status: .error, forController: self)
        }
    }
    
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    
}
