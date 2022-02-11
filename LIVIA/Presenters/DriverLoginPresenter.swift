//
//  DriverLoginPresenter.swift
//  Shanab
//
//  Created by Macbook on 5/17/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol DriverLoginViewDelegate: class {
    func DriverLoginResult(_ error: Error?, _ result: SuccessError_Model?)
}
class DriverLoginPresenter {
    private let services: Services
    private weak var DriverLoginViewDelegate: DriverLoginViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setDriverLoginViewDelegate(DriverLoginViewDelegate: DriverLoginViewDelegate) {
        self.DriverLoginViewDelegate = DriverLoginViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
}
    func postDriverLogin(email: String, password: String) {
        services.postDriverLogin(email: email, password: password) { [weak self](error: Error?, result: SuccessError_Model?) in
            self?.DriverLoginViewDelegate?.DriverLoginResult(error, result)
        }
        
        self.dismissIndicator()

    }
}
