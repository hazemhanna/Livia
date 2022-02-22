//
//  FoodPackagesDetailsVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit

class FoodPackagesDetailsVC : UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

