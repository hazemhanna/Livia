//
//  AdditionsPresenter.swift
//  Shanab
//
//  Created by Macbook on 7/12/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol AdditionsViewDelegate: class {
    func MealDetailsResult(_ error: Error?, _ details: CollectionDataClass?)
    func postAddToCartResult(_ error: Error?,_ result: SuccessError_Model?)
    
}
class AdditionsPresenter {
    private let services: Services
    private weak var AdditionsViewDelegate: AdditionsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setAdditionsViewDelegate( AdditionsViewDelegate: AdditionsViewDelegate) {
        self.AdditionsViewDelegate = AdditionsViewDelegate
    }
    func showIndicator() {
        
        
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postMealDetails(meal_id: Int) {
        services.postMealDetails(meal_id: meal_id) {[weak self] (error: Error?, details: CollectionDataClass?) in
            self?.AdditionsViewDelegate?.MealDetailsResult(error, details)
            self?.dismissIndicator()
        }
    }
    func postAddToCart(meal_id: Int, quantity: Int, message: String, options: [(id:Int ,qun: Int)]) {
        services.postAddToCart(meal_id: meal_id, quantity: quantity, message: message, options: options) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.AdditionsViewDelegate?.postAddToCartResult(error, result)
            self?.dismissIndicator()
        }
    }
}
