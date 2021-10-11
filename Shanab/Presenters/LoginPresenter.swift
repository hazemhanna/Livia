//
//  LoginPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol LoginViewDelegate: class {
    func LoginResult(_ error: Error?, _ result: SuccessError_Model?)
}
class LoginPresenter {
    private let services: Services
    private weak var LoginViewDelegate: LoginViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setLoginViewDelegate(LoginViewDelegate: LoginViewDelegate) {
        self.LoginViewDelegate = LoginViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postLogin(email: String, password: String) {
        services.postLogin(email: email, password: password) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.LoginViewDelegate?.LoginResult(error, result)
            self?.dismissIndicator()
        }
    }
    
}
