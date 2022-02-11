//
//  DriverChangeProfileProfilePresenter.swift
//  Shanab
//
//  Created by Macbook on 5/17/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol DriverChangePasswordProfileProfileViewDelegate: class {
    func DriverChangePasswordProfileProfileResult(_ error: Error?, _ result: SuccessError_Model?)
}
class DriverChangeProfileProfilePresenter {
    private let services: Services
    private weak var DriverChangePasswordProfileProfileViewDelegate: DriverChangePasswordProfileProfileViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func DriverChangePasswordProfileProfileViewDelegate(DriverChangePasswordProfileProfileViewDelegate:DriverChangePasswordProfileProfileViewDelegate){
        self.DriverChangePasswordProfileProfileViewDelegate = DriverChangePasswordProfileProfileViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postsetDriverChangePasswordProfileProfile(password: String, old_password: String, password_confirmation: String) {
        services.postDriverChangePasswordProfile(password: password, old_password: old_password, password_confirmation: password_confirmation) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.DriverChangePasswordProfileProfileViewDelegate?.DriverChangePasswordProfileProfileResult(error, result)
            self?.dismissIndicator()
        }
    }
    
}
