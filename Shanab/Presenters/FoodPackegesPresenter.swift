//
//  FoodPackegesPresenter.swift
//  Shanab
//
//  Created by MAC on 08/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//


import Foundation
import SVProgressHUD

protocol FoodPackegesViewDelegate: class {
    func getFoodSubscription(_ error: Error?, _ result: [FoodSubscription]?)
    func addFoodSubToCart(_ error: Error?, _ result: AddFoodPackegeToCart?,message : String?)
    func getMyFoodSub(_ error: Error?, _ result: [MyFoodSubscribtion]?)

    
}
class FoodPackegesPresenter {
    private let services: Services
    private weak var subViewDelegate: FoodPackegesViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setsubscribtionViewDelegate(subscribtionsViewDelegate: FoodPackegesViewDelegate) {
        self.subViewDelegate = subscribtionsViewDelegate
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getFoodSubscription(restaurant_id : Int) {
        services.getFoodSub(restaurant_id: restaurant_id) {[weak self] (_ error: Error?, _ result: [FoodSubscription]?) in
            self?.subViewDelegate?.getFoodSubscription(error, result)
            self?.dismissIndicator()
        }
    }
    
    func addFoodSubToCart(restaurant_id: Int ,food_subscription_id: Int ,has_delivery_subscription: Int ,delivery_price: Int ,food_price: Int ,total: Int ) {
        services.addFoodSubToCart(restaurant_id: restaurant_id, food_subscription_id: food_subscription_id, has_delivery_subscription: has_delivery_subscription, delivery_price: delivery_price, food_price: food_price, total: total) {[weak self] (_ error: Error?, _ result: AddFoodPackegeToCart?,message : String?) in
            self?.subViewDelegate?.addFoodSubToCart(error, result,message: message)
            self?.dismissIndicator()
        }
    }

   
    
    func getMyFoodSubscription() {
        services.getMyFoodSub() {[weak self] (_ error: Error?, _ result: [MyFoodSubscribtion]?) in
            self?.subViewDelegate?.getMyFoodSub(error, result)
            self?.dismissIndicator()
        }
    }
}
