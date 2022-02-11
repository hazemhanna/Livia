//
//  UserListPresenter.swift
//  Shanab
//
//  Created by Macbook on 6/2/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserListViewDelegate: class {
    
    func UserListResult(_ error: Error?, _ list: orderpagination?)
    func UserRefundResult(_ error: Error?, _ list: orderpagination?)
    func getUserRewards(_ error: Error?, _ list: [Reward]?)
    func refundOrder(_ error: Error?, _ list: RefundModelJSON?)
    
}


class UserListPresenter {
    private let services: Services
    private weak var UserListViewDelegate: UserListViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setUserListViewDelegate(UserListViewDelegate: UserListViewDelegate) {
        self.UserListViewDelegate = UserListViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserGetList(status: [String] , currentPage : Int,type : String) {
        services.postUserGetOrder(status: status, currentPage: currentPage, type : type) {[weak self] (_ error: Error?, _ list: orderpagination?) in
            self?.UserListViewDelegate?.UserListResult(error, list)
            
            DispatchQueue.main.async {
                
                self?.dismissIndicator()

            }
        }
    }
    
    
    func UserRefundResult(status: [String]) {
        services.postUserGetRefusedOrder(status: status) {[weak self] (_ error: Error?, _ list: orderpagination?) in
            self?.UserListViewDelegate?.UserRefundResult(error, list)
            DispatchQueue.main.async {
                self?.dismissIndicator()
            }
        }
    }
    
    func getUserRewards() {
        services.getUserRewards() {[weak self] (_ error: Error?, _ list: [Reward]?) in
            self?.UserListViewDelegate?.getUserRewards(error, list)
            DispatchQueue.main.async {
                self?.dismissIndicator()
            }
        }
    }
    
    func refundOrder(order_id : Int,rate : Double,refund_reson : String) {
        services.refundOrder(order_id : order_id,rate : rate,refund_reson : refund_reson) {[weak self] (_ error: Error?, _ list: RefundModelJSON?) in
            self?.UserListViewDelegate?.refundOrder(error, list)
            DispatchQueue.main.async {
                self?.dismissIndicator()
            }
        }
    }
    
    
    
}
