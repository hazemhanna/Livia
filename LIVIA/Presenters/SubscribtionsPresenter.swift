//
//  SubscribtionsPresenter.swift
//  Shanab
//
//  Created by MAC on 27/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//



import Foundation
import SVProgressHUD

protocol SubscribtionsViewDelegate: class {
    func subscribtions(_ error: Error?, _ result: [Subscription]?)
    func ApplyingSubscribtion(_ error: Error?, _ result: ApplyingSubscribtion?)
}

class SubscribtionsPresenter {
    private let services: Services
    private weak var subViewDelegate: SubscribtionsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setsubscribtionViewDelegate(subscribtionsViewDelegate: SubscribtionsViewDelegate) {
        self.subViewDelegate = subscribtionsViewDelegate
    }
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }

    
    func getSubscribtions(restaurant_id: Int) {
        services.getSubscribtion(restaurant_id: restaurant_id) {[weak self] (_ error: Error?, _ result: [Subscription]?) in
            self?.subViewDelegate?.subscribtions(error, result)
            self?.dismissIndicator()
        }
    }
    
    func ApplyingSubscribtion(restaurant_id: Int,subscribtionId : Int) {
        services.applyingSubscribtion(restaurant_id: restaurant_id, subscription_id: subscribtionId) {[weak self] (_ error: Error?, _ result: ApplyingSubscribtion?) in
            self?.subViewDelegate?.ApplyingSubscribtion(error, result)
            self?.dismissIndicator()
        }
    }
}
