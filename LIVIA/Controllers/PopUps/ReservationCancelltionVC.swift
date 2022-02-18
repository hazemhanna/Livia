//
//  ReservationCancelltionVC.swift
//  Shanab
//
//  Created by Macbook on 7/12/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ReservationCancelltionVC: UIViewController {
    
    var id = Int()
    
    @IBOutlet weak var CancelFees: UILabel!
    
    @IBOutlet weak var ReservationPaid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func dismiss(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
   }
    
    @IBAction func confirm(_ sender: Any) {
    }
    
}
