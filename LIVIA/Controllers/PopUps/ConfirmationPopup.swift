//
//  ConfirmationPopup.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ConfirmationPopup: UIViewController {
    
    @IBOutlet weak var titleLbl  : UILabel!

    

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            guard let window = UIApplication.shared.keyWindow else { return }

            guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
            
            details.selectedIndex = 0
            window.rootViewController = details
            // code to remove your view
        }

    }
    

  
    @IBAction func dismiss(_ sender: UIButton) {
      
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 0
        window.rootViewController = details
    }
    
}
