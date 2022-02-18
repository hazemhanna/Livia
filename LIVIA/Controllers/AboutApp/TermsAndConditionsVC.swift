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
    @IBOutlet weak var TermsAndCond: UITextView!
    @IBOutlet weak var TermsLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if "lang".localized == "ar" {
            TermsLb.textAlignment = .right
        }else{
            TermsLb.textAlignment = .left
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

