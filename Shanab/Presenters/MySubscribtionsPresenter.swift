//
//  MySubscribtionsPresenter.swift
//  Shanab
//
//  Created by MAC on 27/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//




import Foundation
import SVProgressHUD

protocol MySubscribtionsViewDelegate: class {
    
    func mySubscribtions(_ error: Error?, _ result: [SubscriptionElement]?)
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?)
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?)
 
}
class MySubscribtionsPresenter {
    private let services: Services
    private weak var subViewDelegate: MySubscribtionsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setsubscribtionViewDelegate(subscribtionsViewDelegate: MySubscribtionsViewDelegate) {
        self.subViewDelegate = subscribtionsViewDelegate
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }

    
    func getSubscribtions() {
        services.getMySubscribtion() {[weak self] (_ error: Error?, _ result: [SubscriptionElement]?) in
            self?.subViewDelegate?.mySubscribtions(error, result)
            self?.dismissIndicator()
        }
    }
    
    func postCreateFavorite(item_id: Int, item_type: String) {
        services.postCreateFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.subViewDelegate?.FavoriteResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postRemoveFavorite(item_id: Int, item_type: String) {
        services.postRemoveFavorite(item_id: item_id, item_type: item_type) { [weak self] (error: Error?, result: SuccessError_Model?) in
            self?.subViewDelegate?.RemoveFavorite(error, result)
            self?.dismissIndicator()
        }
    }
}
