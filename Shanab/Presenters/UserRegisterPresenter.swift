//
//  UserRegisterPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserRegisterViewDelegate: class {
    func userRegisterResult(_ error: Error?, _ result: SuccessError_Model?)
    func LoginResult(_ error: Error?, _ result: SuccessError_Model?)
}
class UserRegisterPresenter {
    private let services: Services
    private weak var UserRegisterViewDelegate: UserRegisterViewDelegate?
    init(servcies: Services) {
        self.services = servcies
    }
    func setUserRegisterViewDelegate(UserRegisterViewDelegate: UserRegisterViewDelegate) {
        self.UserRegisterViewDelegate = UserRegisterViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserRegister(name: String, email: String, password: String, password_confirmation: String, phone: String) {
        services.postUserRegister(name: name, email: email, password: password, phone: phone, password_confirmation: password_confirmation) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.UserRegisterViewDelegate?.userRegisterResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postLogin(email: String, password: String) {
        services.postLogin(email: email, password: password) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.UserRegisterViewDelegate?.LoginResult(error, result)
            self?.dismissIndicator()
        }
    }
}
