//
//  NumberListPopUp.swift
//  Shanab
//
//  Created by Macbook on 6/3/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class NumberListPopUp: UIViewController {
    @IBOutlet weak var moreThan5Number: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

  
    @IBAction func dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
