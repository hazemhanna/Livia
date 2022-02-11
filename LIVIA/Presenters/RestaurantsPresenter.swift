//
//  RestaurantsPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/13/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol RestaurantsViewDelegate: class {
    func getAllRestaurantsResult(_ error: Error?, _ restaurants: [Restaurant]?)
   func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
   func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
}
class RestaurantsPresenter {
    private let services: Services
    private weak var RestaurantsViewDelegate: RestaurantsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setRestaurantsViewDelegate( RestaurantsViewDelegate: RestaurantsViewDelegate) {
        self.RestaurantsViewDelegate = RestaurantsViewDelegate
    }
    func showIndicator() {
           SVProgressHUD.show()
       }
       func dismissIndicator() {
           SVProgressHUD.dismiss()
       }
       func getCategoreyList() {
}
    func getAllRestaurants(type: [String]) {
        services.getAllRestaurants(type: type) {[weak self] (error: Error?, restaurants: [Restaurant]?) in
            self?.RestaurantsViewDelegate?.getAllRestaurantsResult(error, restaurants)
            self?.dismissIndicator()
        }
    }
    func postCreateFavorite(item_id: Int, item_type: String) {
              services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
                  self?.RestaurantsViewDelegate?.FavoriteResult(error, result)
                  self?.dismissIndicator()
              }
          }
          func postRemoveFavorite(item_id: Int, item_type: String) {
              services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
                  self?.RestaurantsViewDelegate?.RemoveFavorite(error, result)
                  self?.dismissIndicator()
              }
          }
   
}
