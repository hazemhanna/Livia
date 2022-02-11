//
//  UserProfileChangePasswordPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserProfileChangePasswordViewDelegate: class {
    func UserProfileChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?)
}
class UserProfileChangePasswordPresenter {
    private let services: Services
    private weak var UserProfileChangePasswordViewDelegate: UserProfileChangePasswordViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setUserProfileChangePasswordViewDelegate(UserProfileChangePasswordViewDelegate: UserProfileChangePasswordViewDelegate) {
        self.UserProfileChangePasswordViewDelegate = UserProfileChangePasswordViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserProfileChangePassword(password: String, old_password: String, password_confirmation: String) {
        services.postUserProfileChangePassword(password: password, old_password: old_password, password_confirmation: password_confirmation) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.UserProfileChangePasswordViewDelegate?.UserProfileChangePasswordResult(error, result)
            self?.dismissIndicator()
        }
    }
    
}
