//
//  LoginVC.swift
//  Shanab
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func login(_ sender: UIButton) {
      //  guard self .validate() else {return}
      //  guard let email = EmailTF.text else {return}
       // guard let password = passwordTF.text else {return}
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        
        
    }
    
    private func validate()-> Bool {
        if self.EmailTF.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your phone".localized , status: .error, forController: self)
            return false
        } else if self.passwordTF.text!.isEmpty {
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    @IBAction func registeration(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "RegisterationVC") as? RegisterationVC else {return}

        self.navigationController?.pushViewController(sb, animated: true)
    }

    
}
extension LoginVC{
    
    
    
}
