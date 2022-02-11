//
//  UserOrderDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 7/6/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserOrderDetailsViewDelegate: class {
    func UserOrderDetailsResult(_ error: Error?, _ result: [DriverOrder]?)
    func getCartResult(_ error: Error?, _ result: String?)
    func paidOrder(_ error: Error?, _ result: OrderPaymentModelJSON?)
    func getWebView(_ error: Error?, _ result: WebViewModel?)
    
}
class UserOrderDetailsPresenter {
    private let services: Services
    private weak var UserOrderDetailsViewDelegate: UserOrderDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setUserOrderDetailsViewDelegate( UserOrderDetailsViewDelegate: UserOrderDetailsViewDelegate) {
        self.UserOrderDetailsViewDelegate = UserOrderDetailsViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserOrderDetails(id: Int, status: String) {
        services.postUserOrderDetail(id: id, status: status) {[weak self] (error: Error?, result:[ DriverOrder]?) in
            self?.dismissIndicator()
            self?.UserOrderDetailsViewDelegate?.UserOrderDetailsResult(error, result)
        }
    }
    
    func getCartItems() {
        services.getCartItems {[weak self] (error: Error?, result: OnlinetDataClass?) in
            self?.UserOrderDetailsViewDelegate?.getCartResult(error, result?.vat)
            self?.dismissIndicator()
        }
    }
    
    func paidOrder(id: Int) {
           services.paidOrder(order_id:id) {[weak self] (error: Error?, result: OrderPaymentModelJSON?) in
            self?.UserOrderDetailsViewDelegate?.paidOrder(error, result)
               self?.dismissIndicator()
           }
       }
    
    func getWebView(order_id : Int) {
           services.getWebViewLink(order_id : order_id) {[weak self] (error: Error?, result: WebViewModel?) in
            self?.UserOrderDetailsViewDelegate?.getWebView(error, result)
               self?.dismissIndicator()
           }
       }
    
}
