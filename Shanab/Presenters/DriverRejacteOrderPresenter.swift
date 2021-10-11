//
//  DriverRejacteOrderPresenter.swift
//  Shanab
//
//  Created by mac on 2/13/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//


import Foundation
import SVProgressHUD
protocol DriverRejacteOrderNotificationViewDelegate: class {
    func postDriverRejactOrderResult(_ error: Error?, _ result: SuccessError_Model?)
}
class DriverRejactOrderNotificationPresenter {
    private let services: Services
    private weak var DriverRejacteOrderNotificationViewDelegate: DriverRejacteOrderNotificationViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setDriverRejacteOrderNotificationViewDelegate( DriverRejacteOrderNotificationViewDelegate: DriverRejacteOrderNotificationViewDelegate) {
        self.DriverRejacteOrderNotificationViewDelegate = DriverRejacteOrderNotificationViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postWorkerCancelOrder(order_id: Int , status: String) {
        services.posDriverRejactedOrder(order_id: order_id, status: status) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.DriverRejacteOrderNotificationViewDelegate?.postDriverRejactOrderResult(error, result)
            self?.dismissIndicator()
        }
        
    }
}

