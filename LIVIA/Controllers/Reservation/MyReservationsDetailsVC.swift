//
//  MyReservationsDetailsVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
import DropDown
import Cosmos
class MyReservationsDetailsVC   : UIViewController {
    
    @IBOutlet weak var titleLBL : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLBL.text = "MyReservations".localized
        
    }

    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
