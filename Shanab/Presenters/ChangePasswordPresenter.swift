//
//  ChangePasswordPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol ChangePasswordViewDelegate: class {
    func ChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?)
    func DriverChangePasswordResult(_ error: Error?,_ result: SuccessError_Model?)
}
class ChangePasswordPresenter {
    private let services: Services
    private weak var ChangePasswordViewDelegate: ChangePasswordViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setChangePasswordViewDelegate(ChangePasswordViewDelegate: ChangePasswordViewDelegate) {
        self.ChangePasswordViewDelegate = ChangePasswordViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserChangePassword(email: String, password: String, password_confirmation: String) {
        services.postUserChangePassword(email: email, password: password, password_confirmation: password_confirmation) { [weak self](_ error: Error?, _ result: SuccessError_Model?) in
            self?.dismissIndicator()
            self?.ChangePasswordViewDelegate?.ChangePasswordResult(error, result)
        }
    }
    func postDriverChangePassword(email: String, password: String, password_confirmation: String) {
        services.postDriverChangePassword(email: email, password: password, password_confirmation: password_confirmation) { [weak self](_ error: Error?,_ result:  SuccessError_Model?) in
            
            self?.dismissIndicator()
            self?.ChangePasswordViewDelegate?.DriverChangePasswordResult(error, result)
        }
    }
}
