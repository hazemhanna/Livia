//
//  TermsAndConditionsVC.swift
//  Shanab
//
//  Created by Macbook on 6/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {
    @IBOutlet weak var termsAndCondetionsTV: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    private let MailTemplateVCPresenter = MailTempaltePresenter(services: Services())

    var sectionArr = [Setting]()
    
    @IBOutlet weak var TermsAndCond: UITextView!
    
    @IBOutlet weak var TermsLb: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MailTemplateVCPresenter.setMailTempalteViewDelegate(MailTempalteViewDelegate: self)

        
        MailTemplateVCPresenter.showIndicator()
        sectionArr.removeAll()
        MailTemplateVCPresenter.getSettings()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension TermsAndConditionsVC: MailTempalteViewDelegate {
    func mailTempalteResult(_ error: Error?, _ result: [Tempalte]?) {
        
        displayMessage(title: "", message: "Your message was sent".localized, status: .success, forController: self)

    }
    
    func CreateEmail(_ error: Error?, _ result: SuccessError_Model?) {
        
        if result?.successMessage != "" {
            
            displayMessage(title: "", message: "Your message was sent".localized, status: .success, forController: self)
            

            
        } else {
            
            displayMessage(title: "", message: result?.errorMessage ?? "", status: .error, forController: self)
        }
        
        
        
        self.viewDidLoad()
    }
    
   
    
    func SupprortingResult(_ error: Error?, _ result: [Setting]?) {
        guard var settings = result else{ return }
        
        for i in 0..<settings.count {
            switch settings[i].key {
            case "facebook":
                settings[i].SettingImage = #imageLiteral(resourceName: "facebook").pngData()
            case "twitter":
                settings[i].SettingImage = #imageLiteral(resourceName: "twitter").pngData()
            case "instagram":
                settings[i].SettingImage = #imageLiteral(resourceName: "Insta").pngData()
            case "terms":
                
                if "lang".localized == "ar" {
                    
                    TermsLb.text = settings[i].valueAr

                } else {
                    
                    TermsLb.text = settings[i].valueEn

                }
            default:
                    break
            }
        }
       // self.sectionArr = settings
        
        for i in 0..<settings.count {
            
            if settings[i].SettingImage != nil {
                
                self.sectionArr.append(settings[i])
            }
        }
    }
    
}
