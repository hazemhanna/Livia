//
//  ProfileChangePasswordVC.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit

class ProfileChangePasswordVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func popUpAction(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfilePopUp") as? ProfilePopUp else {return}
        sb.goToWallet = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "WalletVc") as? WalletVc else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        sb.goTochangePassword = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileChangePasswordVC") as? ProfileChangePasswordVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        self.present(sb, animated: true, completion: nil)
     
        sb.goToNotification = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "notificationProfileVC") as? notificationProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        
        sb.goTochangeProfile = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ChangeProfileVC") as? ChangeProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
}






