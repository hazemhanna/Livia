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
    private let LoginVCPresenter = LoginPresenter(services: Services())
    var websiteUrl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginVCPresenter.setLoginViewDelegate(LoginViewDelegate: self)
        
        self.tabBarController?.tabBar.isHidden = true

        
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        
        sb.user_type = "customer"
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: Any) {
        
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//
//        guard let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? MainVC else {return}
//
//            window.rootViewController = sb
            //   self.navigationController?.pushViewController(sb, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func prespectiveLogin(_ sender: UIButton) {
        
        
        guard let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SectionsPageVC") as? SectionsPageVC else {return}
        sb.RegisterT = .supplier
        self.navigationController?.pushViewController(sb, animated: true)

       
 }
    @IBAction func login(_ sender: UIButton) {
        guard self .validate() else {return}
        guard var email = EmailTF.text else {return}
        

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
            print(email)
        
        guard let password = passwordTF.text else {return}
        LoginVCPresenter.showIndicator()
        LoginVCPresenter.postLogin(email: email, password: password)
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
    
    @IBAction func DaliveryManLogin(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "DriverLoginVC") as? DriverLoginVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
    @IBAction func registeration(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "VerifyScreen") as? VerifyScreen else {return}
        sb.user = .user
      //  sb.signupType = .login
        self.navigationController?.pushViewController(sb, animated: true)
    }
}
extension LoginVC: LoginViewDelegate {
    func LoginResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
            }else if resultMsg.un_active_account != "" {
                displayMessage(title: "", message: resultMsg.un_active_account, status: .error, forController: self)
            }else if resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
            } else if resultMsg.device_token != [""] {
                displayMessage(title: "", message: resultMsg.device_token[0], status: .error, forController: self)
            } else if resultMsg.account != [""] {
                
                displayMessage(title: "", message: "phone or password wrong".localized, status: .error, forController: self)
            }
        }
    }
    
}
