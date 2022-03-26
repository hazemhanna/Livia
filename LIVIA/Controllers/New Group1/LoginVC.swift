//
//  LoginVC.swift
//  Shanab
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var skipBtn: UIButton!

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        skipBtn.setTitle("skip".localized, for: .normal)
        DataBinding()
    }

    @IBAction func login(_ sender: UIButton) {
        guard self.validate() else {return}
        AuthViewModel.showIndicator()
        self.AttemptToLogin()
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
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        
    }
    
    
    @IBAction func skipBtn(_ sender: UIButton) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)

    }
    
    
    func DataBinding() {
        _ = EmailTF.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = passwordTF.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.password).disposed(by: disposeBag)
    }
    
}

extension LoginVC{
    func AttemptToLogin() {
            self.AuthViewModel.attemptToLogin().subscribe(onNext: { (data) in
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
                 self.AuthViewModel.dismissIndicator()
                if "lang".localized == "ar" {
                    displayMessage(title: "", message: "حدث خطأ حاول مرة اخري", status: .error, forController: self)
                }else{
                    displayMessage(title: "", message: "someting went wrong try again", status: .error, forController: self)
                }
             }
            }, onError: { (error) in
                displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}
