//
//  RegisterationVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import FlagPhoneNumber

enum SignUpScr {
    
    case reservation
    case login
}
class RegisterationVC: UIViewController {
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var password: UITextField!
    var signupType : SignUpScr = .login
    @IBOutlet weak var phone: FPNTextField!{
        
        didSet{
            
            phone.layer.borderWidth = 2
            phone.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var Backbtn: UIButton!
    @IBOutlet weak var LogBtn: UIButton!
    
    
    var dialCode = String()
    @IBOutlet weak var password_confirmation: CustomTextField!
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    private let UserRegisterVCPresenter = UserRegisterPresenter(servcies: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.delegate = self
        if (UserDefaults.standard.value(forKey: ConfigURLs.VerifiedPhone) as? String) == nil {
            phone.isEnabled = true
            email.text = UserDefaults.standard.value(forKey: ConfigURLs.VerifiedEmail) as! String
            email.isEnabled = false
        } else {
            print(UserDefaults.standard.value(forKey: ConfigURLs.VerifiedPhone) as! String)
            phone.isEnabled = false
            phone.flagButton.isHidden = true
            phone.phoneCodeTextField.isHidden = true
            phone.text = UserDefaults.standard.value(forKey: ConfigURLs.VerifiedPhone) as! String
            email.isEnabled = true
        }
        
        
        
        UserRegisterVCPresenter.setUserRegisterViewDelegate(UserRegisterViewDelegate: self)
        
        
        if signupType == .login {
            
            Backbtn.isHidden = false
            LogBtn.isHidden = false
            
        } else {
            
            Backbtn.isHidden = true
            LogBtn.isHidden = true

        }
        
    }
    func setupCountryPHone() {
        
        
        self.phone.displayMode = .picker
        self.phone.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.phone.flagButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.phone.flagButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.phone.attributedPlaceholder = NSAttributedString(string:"Enter Title", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])

        listController.setup(repository: self.phone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.phone.setFlag(countryCode: country.code)
        }
    }
    @IBAction func strongPassword(_ sender: Any) {
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "StrongPasswordPopupVC")
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let name = name.text else {return}
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        guard let password_confirmation = password_confirmation.text else {return}
        guard var phone = phone.text?.removeWhitespace() else {return}
        
         
        phone = phone.removeDash()
        
        
        if UserDefaults.standard.value(forKey: ConfigURLs.VerifiedPhone) != nil {
            
            phone = dialCode + phone
        }
        
       // print(phone)
        UserRegisterVCPresenter.showIndicator()
        UserRegisterVCPresenter.postUserRegister(name: name, email: email, password: password, password_confirmation: password_confirmation, phone: "\(phone)")
        
        
    }
    private func validate() ->Bool {
        if self.name.text!.isEmpty {
            displayMessage(title: "", message: "Enter Your name".localized , status: .error, forController: self)
            return false
        }
        
//        else if self.email.text!.isEmpty {
//            displayMessage(title: "", message: "Enter Your Email".localized, status: .error, forController: self)
//            return false
//        }
        
        else if self.password.text!.count < 6 {
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else if self.password_confirmation.text!.isEmpty {
            displayMessage(title: "", message: "Enter your password".localized, status: .error, forController: self)
            return false
        } else if self.phone.text!.isEmpty {
            displayMessage(title: "", message: "Enter your phone number".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    @IBAction func rejaxPopUpButton(_ sender: UIButton) {
        
    }
    @IBAction func login(_ sender: UIButton) {
        
        
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
      //  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func PasswordMatch(_ sender: CustomTextField) {
        if password_confirmation.text == password.text {
            self.password_confirmation.leftImage = #imageLiteral(resourceName: "check")
        } else {
            print("Password not match")
        }
    }
    @IBAction func backButton(_ sender: Any) {
    guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
    self.navigationController?.pushViewController(sb, animated: true)
    }
}
extension RegisterationVC: UserRegisterViewDelegate {
    func LoginResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
//                UserDefaults.standard.removeObject(forKey: "email")
            } else if resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
            }
            
        }
    }
    
    func userRegisterResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if !resultMsg.successMessage.isEmpty, resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
                
              if phone.text != "" {
                    guard let phoneS = phone.text?.replacingOccurrences(of: "[^0-9+]",
                                                                 with: "",
                                                                 options: .regularExpression) else {return}

                    UserRegisterVCPresenter.postLogin(email: phoneS, password: self.password.text ?? "")

                }
            } else if !resultMsg.name.isEmpty, resultMsg.name != [""] {
                displayMessage(title: "", message: resultMsg.name[0], status: .error, forController: self)
            } else if !resultMsg.email.isEmpty, resultMsg.email != [""] {
                displayMessage(title: "", message: resultMsg.email[0], status: .error, forController: self)
            } else if !resultMsg.phone.isEmpty, resultMsg.phone != [""] {
                displayMessage(title: "", message: resultMsg.phone[0], status: .error, forController: self)
            } else if !resultMsg.password.isEmpty, resultMsg.password != [""] {
                displayMessage(title: "", message: resultMsg.password[0], status: .error, forController: self)
            } else if !resultMsg.password_confirmation.isEmpty, resultMsg.password_confirmation != [""] {
                displayMessage(title: "", message: resultMsg.password_confirmation[0], status: .error, forController: self)
            }
        }
    }
    
}
extension RegisterationVC: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.title = "Countries"
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
        self.dialCode = dialCode
        print(name, dialCode, code) // Output "France", "+33", "FR"
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            
           // self.phone.text = phone.getRawPhoneNumber()
        } else {
          //  displayMessage(title: "", message: "Number not valid", status: .error, forController: self)
        }
    }
    
    
}

extension String {
    
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    
    func removeWhitespace() -> String {
            return self.replace(string: " ", replacement: "")
        }
    
    func removeDash() -> String {
        
        return self.replace(string: "-", replacement: "")
    }
}


