//
//  DriverRegisterPresenter.swift
//  Shanab
//
//  Created by Macbook on 5/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol DriverRegisterViewDelegate: class {
    func DriverRegisterResult(_ error: Error?, _ result: SuccessError_Model?)
    func DriverLoginResult(_ error: Error?, _ result: SuccessError_Model?)
}
class DriverRegisterPresenter {
    private let services: Services
    private weak var DriverRegisterViewDelegate: DriverRegisterViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setDriverRegisterViewDelegate(DriverRegisterViewDelegate: DriverRegisterViewDelegate) {
        self.DriverRegisterViewDelegate = DriverRegisterViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postDriverRegister(name: String, password: String, password_confirmation: String, phone: String, documents: [UIImage], email: String) {
        services.postDriverRegistrtion(name: name, password: password, phone: phone, password_confirmation: password_confirmation, email: email, documents: documents) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.DriverRegisterViewDelegate?.DriverRegisterResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postDriverLogin(email: String, password: String) {
        services.postDriverLogin(email: email, password: password) { [weak self](error: Error?, result: SuccessError_Model?) in
            self?.DriverRegisterViewDelegate?.DriverLoginResult(error, result)
            self?.dismissIndicator()
        }
    }
}
