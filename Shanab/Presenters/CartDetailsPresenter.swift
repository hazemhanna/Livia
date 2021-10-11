//
//  CartDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 06/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol CartDetailsViewDelegate: class {
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?)
}
class CartDetailsPresenter {
    private let services: Services
    private weak var CartDetailsViewDelegate: CartDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setCartDetailsViewDelegate(CartDetailsViewDelegate: CartDetailsViewDelegate) {
        self.CartDetailsViewDelegate = CartDetailsViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postAddToCart(meal_id: Int, quantity: Int, message: String, options: [Int]) {
        services.postAddToCart(meal_id: meal_id, quantity: quantity, message: message, options: nil) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.CartDetailsViewDelegate?.AddToCartResult(error, result)
            self?.dismissIndicator()
        }
    }
}
