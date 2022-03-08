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
    
    
    @IBAction func Menu(_ sender: Any) {
        setupSideMenu()
    }


    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    



    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}

