//
//  OnlineCartPresenter.swift
//  Shanab
//
//  Created by Macbook on 04/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol onlineCartViewDelegate: class {
    func getCartResult(_ error: Error?, _ result: OnlinetDataClass?)
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
    func postDeleteCart(_ error: Error?, _ result: SuccessError_Model?)
//    func CreateOrderResult(_ error: Error?, _ result: SuccessError_Model?)
}
class OnlineCartPresenter {
    private let services: Services
    private weak var onlineCartViewDelegate: onlineCartViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setonlineCartViewDelegate(onlineCartViewDelegate: onlineCartViewDelegate) {
        self.onlineCartViewDelegate = onlineCartViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getCartItems() {
        services.getCartItems {[weak self] (error: Error?, result: OnlinetDataClass?) in
            self?.onlineCartViewDelegate?.getCartResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postCreateFavorite(item_id: Int, item_type: String) {
        services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.onlineCartViewDelegate?.FavoriteResult(error, result)
            self?.dismissIndicator()
        }
    }
     func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.onlineCartViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
    func postDeleteCart(condition: String, id: Int) {
        services.postDeleteCart(condition: condition, id: id) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.dismissIndicator()
            self?.onlineCartViewDelegate?.postDeleteCart(error, result)
        }
    }
   
//    func postUserCreateOrder(lat: Double, long: Double, currency: String, quantity: Int, total: Int, cartItems: [onlineCart], message: String) {
//           services.postUserCreateOrder(lat: lat, long: long, quantity: quantity, currency: currency, total: total, message: message, cartItems: cartItems) {[weak self](error: Error?, result: SuccessError_Model?) in
//               self?.onlineCartViewDelegate?.CreateOrderResult(error, result)
//               self?.dismissIndicator()
//           }
//       }
}
