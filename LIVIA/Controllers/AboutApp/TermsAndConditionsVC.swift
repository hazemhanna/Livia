//
//  TermsAndConditionsVC.swift
//  Shanab
//
//  Created by Macbook on 6/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var TermsAndCond: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if "lang".localized == "ar" {
            TermsAndCond.textAlignment = .right
        }else{
            TermsAndCond.textAlignment = .left
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

