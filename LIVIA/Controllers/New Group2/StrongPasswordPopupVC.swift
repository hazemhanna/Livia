//
//  StrongPasswordPopupVC.swift
//  Shanab
//
//  Created by Macbook on 4/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class StrongPasswordPopupVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
    @IBAction func dissmis(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
