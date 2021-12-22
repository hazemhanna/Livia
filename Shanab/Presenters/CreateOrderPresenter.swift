//
//  CreateOrderPresenter.swift
//  Shanab
//
//  Created by Macbook on 7/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol CreateOrderViewDelegate: class {
    func CreateOrderResult(_ error: Error?, _ result: SuccessError_Model?)
    //func getCartResult(_ error: Error?, _ result: [onlineCart]?)
    func postDeleteCart(_ error: Error?, _ result: SuccessError_Model?)
    func paidOrder(_ error: Error?, _ result: OrderPaymentModelJSON?)
    func getProfileResult( _ error: Error?, _ result: User?)

}
class UserCreateOrderPresenter {
    private let services: Services
    private weak var CreateOrderViewDelegate: CreateOrderViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setCreateViewDelegate(CreateOrderViewDelegate: CreateOrderViewDelegate) {
        self.CreateOrderViewDelegate = CreateOrderViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserCreateOrder(lat: Double, long: Double, currency: String, quantity: Int, total: Double, cartItems: [createOrderModel], message: String, address_id: Int , payment : String , type:String) {
        
        self.showIndicator()

        print(cartItems)
        services.postUserCreateOrder(lat: lat, long: long, quantity: quantity, currency: currency, total: total, message: message, address_id: address_id, cartItems: cartItems, payment: payment, type: type) {[weak self](error: Error?, result: SuccessError_Model?) in
            self?.dismissIndicator()
            self?.CreateOrderViewDelegate?.CreateOrderResult(error, result)
        }
    }
    func getCartItems() {
           services.getCartItems {[weak self] (error: Error?, result: OnlinetDataClass?) in
               // self?.CreateOrderViewDelegate?.getCartResult(error, result?.cart)
                    self?.dismissIndicator()
           }
       }
    func postDeleteCart(condition: String, id: Int?) {
           services.postDeleteCart(condition: condition, id: id) {[weak self] (error: Error?, result: SuccessError_Model?) in
            
            self?.CreateOrderViewDelegate?.postDeleteCart(error, result)
               self?.dismissIndicator()
           }
       }
    
    func paidOrder(id: Int) {
           services.paidOrder(order_id:id) {[weak self] (error: Error?, result: OrderPaymentModelJSON?) in
            self?.CreateOrderViewDelegate?.paidOrder(error, result)
               self?.dismissIndicator()
           }
       }
    
    func getUserProfile() {
        services.getProfile {[weak self] (error: Error?, result: User?) in
            self?.CreateOrderViewDelegate?.getProfileResult(error, result)
            self?.dismissIndicator()
        }
    }
    
    
}
