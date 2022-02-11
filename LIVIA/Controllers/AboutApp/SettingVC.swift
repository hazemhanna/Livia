//
//  SettingVC.swift
//  Shanab
//
//  Created by Macbook on 7/15/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown
import DLRadioButton
import MOLH
class SettingVC: UIViewController {
    @IBOutlet weak var languageType: UIButton!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var arabic: UIButton!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var passwordConfirmationTF: UITextField!
    
    @IBOutlet weak var DriverForgetPassword: UIView!
    
    @IBOutlet weak var english: UIButton!
    private let DriverChangePasswordProfileProfileVCPresenter = DriverChangeProfileProfilePresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        DriverChangePasswordProfileProfileVCPresenter.DriverChangePasswordProfileProfileViewDelegate(DriverChangePasswordProfileProfileViewDelegate: self)
        
        if Helper.getUserRole() == "driver" {
            
            DriverForgetPassword.isHidden = false
        } else {
            
            DriverForgetPassword.isHidden = true

        }
        
        
        if "lang".localized == "ar" {
            self.languageType.setTitle("اللغة", for: .normal)
            self.languageType.contentHorizontalAlignment = .right
            self.arabic.setTitle("اللغة العربية", for: .normal)
            self.arabic.contentHorizontalAlignment = .right
            self.english.setTitle("اللغة الإنجليزية", for: .normal)
            self.english.contentHorizontalAlignment = .right
            english.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            arabic.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        } else {
            self.languageType.setTitle("Language", for: .normal)
            self.languageType.contentHorizontalAlignment = .left
            self.arabic.setTitle("Arabic", for: .normal)
            self.arabic.contentHorizontalAlignment = .left
            self.english.setTitle("English", for: .normal)
            self.english.contentHorizontalAlignment = .left
            english.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            arabic.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
    }
    
    @IBAction func Menu(_ sender: Any) {
        
        setupSideMenu()
    }
    
    @IBAction func strongPassword(_ sender: UIButton) {
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "StrongPasswordPopupVC")
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
    }
    @IBAction func save(_ sender: UIButton) {
        guard self.validate() else { return }
        guard let password = self.newPasswordTF.text else {return}
        guard let old_password = self.oldPasswordTF.text else {return}
        guard let password_confirmation = self.passwordConfirmationTF.text else {return}
        DriverChangePasswordProfileProfileVCPresenter.showIndicator()
        DriverChangePasswordProfileProfileVCPresenter.postsetDriverChangePasswordProfileProfile(password: password, old_password: old_password, password_confirmation: password_confirmation)
        
        
    }
    private func validate() -> Bool {
        if self.newPasswordTF.text!.isEmpty {
            displayMessage(title: "", message: "new password is empty".localized, status: .error, forController: self)
            return false
        } else if self.passwordConfirmationTF.text!.isEmpty {
            displayMessage(title: "", message: "Confirm password is empty".localized, status: .error, forController: self)
            return false
        } else if self.oldPasswordTF.text!.isEmpty {
            displayMessage(title: "", message: "Old password is empty".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    
    
    
    @IBAction func RadioButtonAction(_ radioButton: DLRadioButton) {
        switch radioButton.tag {
        case 1 :
            print("English")
            self.english.setImage(#imageLiteral(resourceName: "icons8-ok"), for: .normal)
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                MOLH.reset()
                Helper.restartApp()
            } else {
                if ("lang".localized == "en") {
                    displayMessage(title: "", message: "Your App is Already in English Language", status: .info, forController: self )
                } else {
                    displayMessage(title: "", message: "البرنامج بالفعل على اللغة الإنجليزية", status: .info, forController: self )
                }
                
            }
        case 2 :
            print("Arabic")
            self.arabic.setImage(#imageLiteral(resourceName: "icons8-ok"), for: .normal)
            if MOLHLanguage.currentAppleLanguage() == "en" {
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
                MOLH.reset()
                Helper.restartApp()
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                
            } else {
                if ("lang".localized == "en") {
                    displayMessage(title: "", message: "Your App is Already in Arabic Language", status: .info, forController: self )
                } else {
                    displayMessage(title: "", message: "البرنامج بالفعل على اللغة العربية", status: .info, forController: self )
                }
                
            }
        default:
            break
        }
    }
}
extension SettingVC: DriverChangePasswordProfileProfileViewDelegate {
    func DriverChangePasswordProfileProfileResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "Done".localized, status: .success, forController: self)
            } else if resultMsg.old_password != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            } else if resultMsg.password_confirmation != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            }
        }
        
        
    }
}


