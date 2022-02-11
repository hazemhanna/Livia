//
//  CartFoodPackegesPresenter.swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//



import Foundation
import SVProgressHUD

protocol CartFoodPackegesViewDelegate: class {
    
    func getFoodSubCart(_ error: Error?, _ result: [FoodCart]?)
    func applyFoodSub(_ error: Error?, _ result: ApplyFoodPackege?)
    func deleteFoodSubCart(_ error: Error?, _ result: OrderPaymentModelJSON?)

}
class CartFoodPackegesPresenter {
    private let services: Services
    private weak var subViewDelegate: CartFoodPackegesViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setsubscribtionViewDelegate(subscribtionsViewDelegate: CartFoodPackegesViewDelegate) {
        self.subViewDelegate = subscribtionsViewDelegate
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getFoodCart() {
        services.getFoodSubCart(){[weak self] (_ error: Error?, _ result: [FoodCart]?) in
            self?.subViewDelegate?.getFoodSubCart(error, result)
            self?.dismissIndicator()
        }
    }
    
    func applyFoodSub(restaurant_id: Int ,food_subscription_id: Int ,has_delivery_subscription: Int ,delivery_price: Double ,food_price: Double ,total: Int ) {
        services.applyFoodSub(restaurant_id: restaurant_id, food_subscription_id: food_subscription_id, has_delivery_subscription: has_delivery_subscription, delivery_price: delivery_price, food_price: food_price, total: total) {[weak self] (_ error: Error?, _ result: ApplyFoodPackege?) in
            self?.subViewDelegate?.applyFoodSub(error, result)
            self?.dismissIndicator()
        }
    }

    func deletegCart(id : Int) {
        services.deleteFoodSubCart(id : id){[weak self] (_ error: Error?, _ result: OrderPaymentModelJSON?) in
            self?.subViewDelegate?.deleteFoodSubCart(error, result)
            self?.dismissIndicator()
        }
    }
   
}
