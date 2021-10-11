//
//  PaymentGatewayVC.swift
//  Shanab
//
//  Created by Macbook on 5/6/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
class PaymentGatewayVC: UIViewController {
    @IBOutlet weak var radioButton: DLRadioButton!
    let Userdefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

    }
    @IBAction func dismiss(_ sender: Any) {
        
        
        
        
    }
    @IBAction func RadioButtonAction(_ sender: DLRadioButton) {
        switch radioButton.tag {
        case 1:
            print("Master Card")
        case 2:
            print("")
        case 3:
            print("")
        case 4:
            print("")
        default:
            break
        }
    }

}
