//
//  MealDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 7/2/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import Foundation
import SVProgressHUD
protocol MealsDetailsViewDelegate: class {
    func RestaurantMealsResult(_ error: Error?, _ meals: [RestaurantMeal]?)
   
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?)
    func SectionDetails(_ error: Error?, _ result: [sectionMeal]?)
   
}
class MealsDetailPresenter {
    private let services: Services
    private weak var MealsDetailsViewDelegate: MealsDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setMealsDetailsViewDelegate(MealsDetailsViewDelegate: MealsDetailsViewDelegate) {
        self.MealsDetailsViewDelegate = MealsDetailsViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getCategoreyList() {
    }
    
    func postRestaurantMeals(restaurant_id: Int, type: String, category_id: Int?) {
        services.postRestaurantMeals(restaurant_id: restaurant_id, type: type, category_id: category_id) {[weak self] (_ error: Error?, _ meals: [RestaurantMeal]?) in
            self?.MealsDetailsViewDelegate?.RestaurantMealsResult(error, meals)
            self?.dismissIndicator()
        }
    }
    func postCreateFavorite(item_id: Int, item_type: String) {
        services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.MealsDetailsViewDelegate?.FavoriteResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.MealsDetailsViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
   
    func postAddToCart(meal_id: Int, quantity: Int, message: String, options: [Int]) {
        services.postAddToCart(meal_id: meal_id, quantity: quantity, message: message, options: nil) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.MealsDetailsViewDelegate?.AddToCartResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getSectionDetails(category_id: Int) {
        services.getMealsOfMainCategory(category_id: category_id) {[weak self] (_ error: Error?, _ result: [sectionMeal]?) in
            self?.MealsDetailsViewDelegate?.SectionDetails(error, result)
            self?.dismissIndicator()
        }
    }
    
}
