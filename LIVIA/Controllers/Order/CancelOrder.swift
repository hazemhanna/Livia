//
//  CancelOrder.swift
//  Livia
//
//  Created by MAC on 20/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit


class CancelOrder : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func Confirm(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
}
