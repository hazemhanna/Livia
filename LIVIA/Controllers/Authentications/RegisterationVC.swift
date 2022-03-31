//
//  RegisterationVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RegisterationVC: UIViewController {
  
    @IBOutlet weak var name: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var phone: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var address: CustomTextField!
    @IBOutlet weak var password_confirmation: CustomTextField!
    @IBOutlet weak var LogBtn: UIButton!

    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        address.placeholder = "address".localized
        phone.placeholder = "phone".localized
        DataBinding()
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        guard self.validate() else {return}
        AuthViewModel.showIndicator()
        attemptToRegister()
        
    }
    
    private func validate() ->Bool {
        if self.name.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your name".localized , status: .error, forController: self)
            return false
        }else if self.email.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your Email".localized, status: .error, forController: self)
            return false
        }else if self.password.text!.isEmpty{
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else if self.password_confirmation.text!.isEmpty{
            displayMessage(title: "", message: "Enter confirm password".localized, status: .error, forController: self)
            return false
        }else if self.address.text!.isEmpty {
            displayMessage(title: "", message: "Enter your address".localized, status: .error, forController: self)
            return false
        }else if self.password_confirmation.text! != self.password.text!{
            displayMessage(title: "", message: "your password not match".localized, status: .error, forController: self)
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
    
    
    func DataBinding() {
        _ = name.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.name).disposed(by: disposeBag)
        _ = email.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = password.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.password).disposed(by: disposeBag)
        _ = password_confirmation.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.confirm_password).disposed(by: disposeBag)
        _ = address.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.address).disposed(by: disposeBag)
        _ = phone.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.phone).disposed(by: disposeBag)
    }
    
    
}

extension RegisterationVC{
    func attemptToRegister() {
            self.AuthViewModel.attemptToRegister().subscribe(onNext: { (data) in
                if data.token != nil {
                 self.AuthViewModel.dismissIndicator()
                  if "lang".localized == "ar" {
                    displayMessage(title: "", message: "تم تسجيل الدخول بنجاح", status: .success, forController: self)
                    }else{
                    displayMessage(title: "", message: "You have Loged in successfully", status: .success, forController: self)
                    }
                 guard let window = UIApplication.shared.keyWindow else { return }
                 let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
                sb.selectedIndex = 0
                window.rootViewController = sb
                UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
                }else{
                    if data.msg?.email?[0] ?? "" != "" {
                        self.AuthViewModel.dismissIndicator()
                        displayMessage(title: "", message: data.msg?.email?[0] ?? "", status: .error, forController: self)

                    }else{
                        self.AuthViewModel.dismissIndicator()
                       if "lang".localized == "ar" {
                           displayMessage(title: "", message: "حدث خطأ حاول مرة اخري", status: .error, forController: self)
                       }else{
                           displayMessage(title: "", message: "someting went wrong try again", status: .error, forController: self)
                       }
                    }
                    
             }
            }, onError: { (error) in
                displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}



