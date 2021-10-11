//
//  FavoritMealsPresernter.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol FavoriteMealsViewDelegate: class {
    func UserFavoriteMealssResult(_ error: Error?, _ favoriteList: [Favorites]?)
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
    }
    class UserFavoritesMealsPresenter {
        private let services: Services
        private weak var FavoriteMealsViewDelegate: FavoriteMealsViewDelegate?
        init(services: Services) {
            self.services = services
        }
        func setFavoriteMealsViewDelegate(FavoriteMealsViewDelegate: FavoriteMealsViewDelegate) {
            self.FavoriteMealsViewDelegate = FavoriteMealsViewDelegate
        }
        func showIndicator() {
            SVProgressHUD.show()
        }
        func dismissIndicator() {
            SVProgressHUD.dismiss()
        }
        func postFavoriteGet(item_type: String) {
            services.PostfavorieGet(item_type: item_type) {[weak self] (_ error: Error?, _ favoriteList: [Favorites]?) in
                self?.FavoriteMealsViewDelegate?.UserFavoriteMealssResult(error, favoriteList)
                self?.dismissIndicator()
            }
        }
        func postAddToCart(meal_id: Int, quantity: Int, message: String, options: [Int]) {
            services.postAddToCart(meal_id: meal_id, quantity: quantity, message: message, options: nil) {[weak self] (error: Error?, result: SuccessError_Model?) in
                self?.FavoriteMealsViewDelegate?.AddToCartResult(error, result)
                self?.dismissIndicator()
            }
        }
        func postRemoveFavorite(item_id: Int, item_type: String) {
                 services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
                     self?.FavoriteMealsViewDelegate?.RemoveFavorite(error, result)
                     self?.dismissIndicator()
                 }
             }
    }
