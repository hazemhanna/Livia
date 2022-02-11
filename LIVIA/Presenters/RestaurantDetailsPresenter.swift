//
//  RestaurantDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol RestaurantDetailsViewDelegate: class {
    func RestaurantDetailsResult(_ error: Error?, _ details: RestaurantDetail?)
    func RestaurantMealsResult(_ error: Error?, _ meals: [RestaurantMeal]?)
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?)
    func CatgeoriesResult( _ error: Error?, _ catgeory: [Category]?)
//    func SectionDetails(_ error: Error?, _ result: [sectionMeal]?)
    }
class RestaurantDetailPresenter {
    private let services: Services
    private weak var RestaurantDetailsViewDelegate: RestaurantDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setRestaurantDetailsViewDelegate(RestaurantDetailsViewDelegate: RestaurantDetailsViewDelegate) {
        self.RestaurantDetailsViewDelegate = RestaurantDetailsViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getCategoreyList() {
    }
    func postRestaurantDetails(restaurant_id: Int) {
        
        print(restaurant_id)
        services.postRestaurantDetails(restaurant_id: restaurant_id) {[weak self] (error: Error?,  details: RestaurantDetail?) in
            self?.RestaurantDetailsViewDelegate?.RestaurantDetailsResult(error, details)
            self?.dismissIndicator()
        }
    }
    func postRestaurantMeals(restaurant_id: Int, type: String, category_id: Int?) {
        services.postRestaurantMeals(restaurant_id: restaurant_id, type: type, category_id: category_id) {[weak self] (_ error: Error?, _ meals: [RestaurantMeal]?) in
            self?.RestaurantDetailsViewDelegate?.RestaurantMealsResult(error, meals)
            self?.dismissIndicator()
        }
    }
    func postCreateFavorite(item_id: Int, item_type: String) {
        services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.RestaurantDetailsViewDelegate?.FavoriteResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.RestaurantDetailsViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
    func postAddToCart(meal_id: Int, quantity: Int, message: String, options: [Int]) {
        services.postAddToCart(meal_id: meal_id, quantity: quantity, message: message, options: nil) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.RestaurantDetailsViewDelegate?.AddToCartResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getCatgeories() {
        services.getAllCatgeories { [weak self] (_ error: Error?, _ catgeory: [Category]?) in
            self?.RestaurantDetailsViewDelegate?.CatgeoriesResult(error, catgeory)
            self?.dismissIndicator()
        }
        
    }
//    func getSectionDetails(category_id: Int) {
//        services.getMealsOfMainCategory(category_id: category_id) {[weak self] (_ error: Error?, _ result: [sectionMeal]?) in
//            self?.RestaurantDetailsViewDelegate?.SectionDetails(error, result)
//            self?.dismissIndicator()
//        }
//    }
}
