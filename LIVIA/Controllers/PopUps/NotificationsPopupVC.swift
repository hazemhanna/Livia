//
//  NotificationsPopupVC.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class NotificationsPopupVC: UIViewController {
private let DriverRejactOrderVCPresenter = DriverRejactOrderNotificationPresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()

        DriverRejactOrderVCPresenter.setDriverRejacteOrderNotificationViewDelegate(DriverRejacteOrderNotificationViewDelegate: self)
    }
    

    @IBAction func acceptance(_ sender: UIButton) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
        Details.order_id = AppDelegate.item_id
      
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
   
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension NotificationsPopupVC: DriverRejacteOrderNotificationViewDelegate {
    func postDriverRejactOrderResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
                self.dismiss(animated: true, completion: nil)
                
            } else if resultMsg.order_id != [""] {
                displayMessage(title: "", message: resultMsg.order_id[0], status: .error, forController: self)
            }
        }
    }
    
    
}
