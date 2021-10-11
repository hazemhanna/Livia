//
//  SideMenuPresenter.swift
//  Shanab
//
//  Created by Macbook on 6/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol SideMenuViewDelegate: class {
    func getProfileResult( _ error: Error?, _ result: User?)
       func getDriverProfileResult(_ error: Error?, _ result: User?)
}
class SideMenuPresenter {
    private let services: Services
    private weak var SideMenuViewDelegate: SideMenuViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setSideMenuViewDelegate(SideMenuViewDelegate: SideMenuViewDelegate) {
        self.SideMenuViewDelegate = SideMenuViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getUserProfile() {
        services.getProfile {[weak self] (error: Error?, result: User?) in
            self?.SideMenuViewDelegate?.getProfileResult(error, result)
            self?.dismissIndicator()
        }
       }
     func getDriverProfile() {
            services.getDriverProfile { [weak self](error: Error?, result: User?) in
                self?.SideMenuViewDelegate?.getDriverProfileResult(error, result)
                self?.dismissIndicator()
            }
        }
}
