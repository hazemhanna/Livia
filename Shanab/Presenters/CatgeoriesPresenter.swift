//
//  CatgeoriesPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol CatgeoriesViewDelegate: class {
    func CatgeoriesResult( _ error: Error?, _ catgeory: [Category]?)
}
class CatgeoriesPresenter {
    private let services: Services
    private weak var CatgeoriesViewDelegate: CatgeoriesViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setCatgeoriesViewDelegate(CatgeoriesViewDelegate: CatgeoriesViewDelegate) {
        self.CatgeoriesViewDelegate = CatgeoriesViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getCatgeories() {
        services.getAllCatgeories { [weak self] (_ error: Error?, _ catgeory: [Category]?) in
            self?.CatgeoriesViewDelegate?.CatgeoriesResult(error, catgeory)
            self?.dismissIndicator()
        }
        
    }
}
