//
//  CustomerRateVC.swift
//  Shanab
//
//  Created by Macbook on 3/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
class CustomerRateVC: UIViewController {
    @IBOutlet weak var cosmos: CosmosView!
    
    @IBOutlet weak var review: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func send(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
