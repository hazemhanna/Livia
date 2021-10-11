//
//  VerifyScreen.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import SVProgressHUD
import FlagPhoneNumber

enum userType {
    
    case user
    case agent
}
class VerifyScreen: UIViewController {
    
    
   // @IBOutlet weak var EmailOrPhone: CustomTextField!
    
    @IBOutlet weak var EmailOrPhone: FPNTextField! {
        
        didSet{
            
            EmailOrPhone.layer.borderWidth = 2
            EmailOrPhone.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .plain)

    var dialCode = "+966"

    var user : userType?
    var signupType : SignUpScr = .login

    @IBOutlet weak var BackBtn: UIButton!
    
    var presenter : VerifyPresenter?
    
    var verificationText = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.removeObject(forKey: ConfigURLs.VerifiedEmail)
        UserDefaults.standard.removeObject(forKey: ConfigURLs.VerifiedPhone)

        
        if signupType == .reservation {
            
            BackBtn.isHidden = true
            
        } else {
            
            BackBtn.isHidden = false

        }
        presenter = VerifyPresenter(view: self)
        
        setupCountryPHone()
        EmailOrPhone.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func setupCountryPHone() {
        
        
        self.EmailOrPhone.displayMode = .picker
        self.EmailOrPhone.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.EmailOrPhone.flagButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.EmailOrPhone.flagButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.EmailOrPhone.setFlag(key: .SA)
        self.EmailOrPhone.attributedPlaceholder = NSAttributedString(string:"", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])

        listController.setup(repository: self.EmailOrPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.EmailOrPhone.setFlag(countryCode: country.code)
            self?.dialCode = country.code.rawValue
        }
        
    }
    @IBAction func Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func SendEmail(_ sender: UIButton) {
        
        if EmailOrPhone.text != "" {
//            
//            if EmailOrPhone.text?.contains("@") == false {
//                
//                
//                if EmailOrPhone.text?.first == "+" {
//                    
//                    EmailOrPhone.text?.remove(at: EmailOrPhone.text?.startIndex ?? "".startIndex)
//                }
//
//                
//                let prefix = EmailOrPhone.text?.prefix(3)
//                
//                
//                if prefix != "966" {
//                    
//                    EmailOrPhone.text = "966" + (EmailOrPhone.text ?? "")
//                }
//            
//            } else {
//                
//                verificationText = EmailOrPhone.text!
//            }
            
            if dialCode.first == "+" {
                
                dialCode.removeFirst()

            }
            
            print(dialCode)
            verificationText = dialCode + EmailOrPhone.text!

            print(verificationText)
            let purePhoneNumber = verificationText.replacingOccurrences(of: "[^0-9+]",
                                                                   with: "",
                                                                   options: .regularExpression)

            
            presenter?.verifyEmail(email: purePhoneNumber, usertype: user ?? .user)

        } else {
            
            displayMessage(title: "", message: "Enter your phone".localized, status: .error, forController: self)
        }
        
    }
    

}

extension VerifyScreen : VerifyView {
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func UserEmailVerified(_ error: Error?, _ success: SuccessError_Model?) {
        
        if success?.successMessage != "" {
            
            
            if ((EmailOrPhone.text?.contains("@")) != false) {
                
                displayMessage(title: "", message: "Code sent to your email".localized, status: .success, forController: self)
                
                UserDefaults.standard.setValue(verificationText, forKey: ConfigURLs.VerifiedEmail)
            } else {
                
                displayMessage(title: "", message: "Code sent to your phone".localized, status: .success, forController: self)
                
                print(verificationText)
                UserDefaults.standard.setValue(verificationText, forKey: ConfigURLs.VerifiedPhone)
                
                print(UserDefaults.standard.value(forKey: ConfigURLs.VerifiedPhone))
                
            }
            
            guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "VerifyCode") as? VerifyCodeVC else {return}
            
            sb.user = user ?? .user
                   self.navigationController?.pushViewController(sb, animated: true)
            
        } else if success?.email != [""] {
            
            
            displayMessage(title: "", message:  success?.email[0] ?? "" , status: .error, forController: self)
        }

    }
    
    func DriverEmailVerified(_ error: Error?, _ success: SuccessError_Model?) {
        
        if success?.successMessage != "" {
            
            if ((EmailOrPhone.text?.contains("@")) != false) {
                
                displayMessage(title: "", message: "Code sent to your email".localized, status: .success, forController: self)
                
                UserDefaults.standard.setValue(verificationText, forKey: ConfigURLs.VerifiedEmail)
            } else {
                
                displayMessage(title: "", message: "Code sent to your phone".localized, status: .success, forController: self)
                
                UserDefaults.standard.setValue(verificationText, forKey: ConfigURLs.VerifiedPhone)
            }
            
            guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "VerifyCode") as? VerifyCodeVC else {return}
            
            sb.user = user ?? .agent
                   self.navigationController?.pushViewController(sb, animated: true)

        } else if success?.email != [""] {
            
            
            displayMessage(title: "", message:  success?.email[0] ?? "" , status: .error, forController: self)
        }
    }
    
    
    
}



extension VerifyScreen: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.title = "Countries"
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
        self.dialCode = code
        print(name, dialCode, code) // Output "France", "+33", "FR"
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            
            print(textField)
            self.EmailOrPhone.text = EmailOrPhone.getRawPhoneNumber()
        } else {
          //  displayMessage(title: "", message: "Number not valid", status: .error, forController: self)
        }
    }
    
    
}
