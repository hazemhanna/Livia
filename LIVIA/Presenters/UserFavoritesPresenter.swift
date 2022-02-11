//
//  UserFavoritesPresenter.swift
//  Shanab
//
//  Created by Macbook on 5/26/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserFavoritesViewDelegate: class {
    func UserFavoritesResult(_ error: Error?, _ favoriteList: [Favorites]?)
     func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
}
class UserFavoritesPresenter {
    private let services: Services
    private weak var UserFavoritesViewDelegate: UserFavoritesViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setUserFavoritesViewDelegate(UserFavoritesViewDelegate: UserFavoritesViewDelegate) {
        self.UserFavoritesViewDelegate = UserFavoritesViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postFavoriteGet(item_type: String) {
        services.PostfavorieGet(item_type: item_type) {[weak self] (_ error: Error?, _ favoriteList: [Favorites]?) in
            self?.UserFavoritesViewDelegate?.UserFavoritesResult(error, favoriteList)
            self?.dismissIndicator()
        }
    }
    func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.UserFavoritesViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
}
