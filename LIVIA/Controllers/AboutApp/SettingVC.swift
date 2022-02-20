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
    @IBOutlet weak var arabic: UIButton!
    @IBOutlet weak var english: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
            
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


