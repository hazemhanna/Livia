//
//  ProfilePopUp.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class ProfilePopUp: UIViewController {
    
    var goToWallet: (() ->Void)? = nil

    var goTochangeProfile: (() ->Void)? = nil
    var goTochangePassword: (() ->Void)? = nil
    var goToNotification: (() ->Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func walletAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        goToWallet?()
    }
    
    @IBAction func notificationAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        goToNotification?()
    }
    
    @IBAction func changePasswordAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        goTochangePassword?()
    }
    
    @IBAction func chageProfileAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        goTochangeProfile?()
    }
    
  
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
