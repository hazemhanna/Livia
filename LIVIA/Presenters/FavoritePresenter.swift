//
//  FavoritePresenter.swift
//  Shanab
//
//  Created by Macbook on 6/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol FavoriteViewDelegate: class {
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
}
class FavoritePresenter {
    private let services: Services
    private weak var FavoriteViewDelegate: FavoriteViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setFavoriteViewDelegate(FavoriteViewDelegate: FavoriteViewDelegate) {
        self.FavoriteViewDelegate = FavoriteViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postCreateFavorite(item_id: Int, item_type: String) {
        services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.FavoriteViewDelegate?.FavoriteResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.FavoriteViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
}
