//
//  DriverGetCodePresenter.swift
//  Shanab
//
//  Created by Macbook on 5/13/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol DriverGetCodeViewDelegate: class {
    func DriverGetCodeResult(_ error: Error?, _ result: SuccessError_Model?)
}
class DriverGetCodePresenter {
    private let services: Services
    private weak var DriverGetCodeViewDelegate: DriverGetCodeViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setDriverGetCodeViewDelegate(DriverGetCodeViewDelegate: DriverGetCodeViewDelegate) {
        self.DriverGetCodeViewDelegate = DriverGetCodeViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postDriverGetCode(email: String) {
        services.postDriverGetCode(email: email) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.DriverGetCodeViewDelegate?.DriverGetCodeResult(error, result)
            self?.dismissIndicator()
        }
    }
}
