//
//  RatingVC.swift
//  Shanab
//
//  Created by Macbook on 4/12/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
class RatingVC: UIViewController {
    
    @IBOutlet weak var OrderRate: CosmosView!
    @IBOutlet weak var agentRate: CosmosView!
    var rate = 0.5
    var DriverRate = 0.5
    var order_id = Int()
    @IBOutlet weak var discreption: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
