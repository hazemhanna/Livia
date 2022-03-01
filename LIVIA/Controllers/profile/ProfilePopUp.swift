//
//  ProfilePopUp.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class ProfilePopUp: UIViewController {
    
    @IBOutlet weak var wallettn : UIButton!
    @IBOutlet weak var notificationtn : UIButton!
    @IBOutlet weak var passwordtn : UIButton!
    @IBOutlet weak var profilebtn : UIButton!
    @IBOutlet weak var titleLbl  : UILabel!

    var goToWallet: (() ->Void)? = nil

    var goTochangeProfile: (() ->Void)? = nil
    var goTochangePassword: (() ->Void)? = nil
    var goToNotification: (() ->Void)? = nil

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
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}
