//
//  ProfilePopUp.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfilePopUp: UIViewController {
    
    @IBOutlet weak var wallettn : UIButton!
    @IBOutlet weak var notificationtn : UIButton!
    @IBOutlet weak var passwordtn : UIButton!
    @IBOutlet weak var profilebtn : UIButton!

    
    var goToWallet: (() ->Void)? = nil
    var goTochangeProfile: (() ->Void)? = nil
    var goTochangePassword: (() ->Void)? = nil
    var goToNotification: (() ->Void)? = nil

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallettn.setTitle("wallet".localized, for: .normal)
        passwordtn.setTitle("Password changed".localized, for: .normal)
        notificationtn.setTitle("Notifications".localized, for: .normal)
        profilebtn.setTitle("changeProfile".localized, for: .normal)
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

