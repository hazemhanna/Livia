//
//  GetAddsPresenter.swift
//  Shanab
//
//  Created by Macbook on 4/13/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol GetAddsViewDelegate: class {
    func getAddsResult(_ error: Error?, _ result: [Add]?)
    func CatgeoriesResult( _ error: Error?, _ catgeory: [Category]?)
    func getAllRestaurantsResult(_ error: Error?, _ restaurants: [Restaurant]?)
    func RestaurantSearchResult(_ error: Error?, _ restaurantResult: [SearchResult]?)
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
}
class GetAddsPresenter {
    private let services: Services
    private weak var GetAddsViewDelegate: GetAddsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setGetAddsViewDelegate(GetAddsViewDelegate: GetAddsViewDelegate) {
        self.GetAddsViewDelegate = GetAddsViewDelegate
    }
    func showIndicator() {
        
        DispatchQueue.main.async {
            
            SVProgressHUD.show()

        }
        
    }
    func dismissIndicator() {
        
        DispatchQueue.main.async {
            
            SVProgressHUD.dismiss()

        }
    }
    func getCategoreyList() {
    }
    func getAdds(item_id: Int, item_type: String){
        
        services.getAdds(item_id: item_id, item_type: item_type) { [weak self](error: Error?,
            result: [Add]?) in
            self?.GetAddsViewDelegate?.getAddsResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getCatgeories() {

        services.getAllCatgeories { [weak self] (_ error: Error?, _ catgeory: [Category]?) in
            self?.GetAddsViewDelegate?.CatgeoriesResult(error, catgeory)
            self?.dismissIndicator()
        }
        
    }
    func getAllRestaurants(type: [String]) {
        services.getAllRestaurants(type: type) {[weak self] (error: Error?, restaurants: [Restaurant]?) in
            self?.GetAddsViewDelegate?.getAllRestaurantsResult(error, restaurants)
            self?.dismissIndicator()
        }
    }
      func postRestaurantSearch(word: String) {
        self.showIndicator()

           services.postSearchRestauran(word: word) {[weak self] (error: Error?, result: [SearchResult]?) in
               self?.GetAddsViewDelegate?.RestaurantSearchResult(error, result)
               self?.dismissIndicator()
           }
       }
    func postCreateFavorite(item_id: Int, item_type: String) {
        self.showIndicator()

           services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.dismissIndicator()
               self?.GetAddsViewDelegate?.FavoriteResult(error, result)
           }
       }
       func postRemoveFavorite(item_id: Int, item_type: String) {
        self.showIndicator()

           services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.dismissIndicator()
               self?.GetAddsViewDelegate?.RemoveFavorite(error, result)
           }
       }
}
