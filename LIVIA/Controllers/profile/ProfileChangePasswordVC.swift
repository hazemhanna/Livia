//
//  ProfileChangePasswordVC.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class ProfileChangePasswordVC: UIViewController {
    
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var newPassword: CustomTextField!
    @IBOutlet weak var password_confirmation: CustomTextField!
    @IBOutlet weak var oldPassword: CustomTextField!

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "Password changed".localized
        DataBinding()

    }
    
    @IBAction func popUpAction(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfilePopUp") as? ProfilePopUp else {return}
        sb.goToWallet = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "WalletVc") as? WalletVc else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        sb.goTochangePassword = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileChangePasswordVC") as? ProfileChangePasswordVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        self.present(sb, animated: true, completion: nil)
     
        sb.goToNotification = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "notificationProfileVC") as? notificationProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        
        sb.goTochangeProfile = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ChangeProfileVC") as? ChangeProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    @IBAction func updatePass(_ sender: UIButton) {
        guard self.validate() else {return}
        AuthViewModel.showIndicator()
        updatePassword()
    }
    
    private func validate() ->Bool {
        if self.oldPassword.text!.isEmpty {
            displayMessage(title: "", message: "Old password is empty".localized, status: .error, forController: self)
            return false
        }else if self.newPassword.text!.isEmpty{
            displayMessage(title: "", message: "Enter new password".localized, status: .error, forController: self)
            return false
        }else if self.password_confirmation.text!.isEmpty{
            displayMessage(title: "", message: "Enter confirm password".localized, status: .error, forController: self)
            return false
        }else if self.newPassword.text!.count < 8{
            displayMessage(title: "", message: "bill".localized, status: .error, forController: self)
            return false
        } else if self.password_confirmation.text! != self.newPassword.text!{
            displayMessage(title: "", message: "your password not match".localized, status: .error, forController: self)
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
        _ = oldPassword.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.oldPassword).disposed(by: disposeBag)
        _ = newPassword.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.password).disposed(by: disposeBag)
        _ = password_confirmation.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.confirm_password).disposed(by: disposeBag)
    }
    
    
    
    func updatePassword() {
        self.AuthViewModel.POSTChangePassowrd().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            Helper.LogOutUser()
            guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    
}






