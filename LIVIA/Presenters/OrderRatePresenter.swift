//
//  OrderRatePresenter.swift
//  Shanab
//
//  Created by mac on 2/24/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol OrderRateViewDelegate: class {
    func postRateResult(_ error: Error?, _ result: SuccessError_Model?)
    func postRateDriverResult(_ error: Error?, _ result: SuccessError_Model?)
    func postCommentRateResult(_ error: Error?, _ result: SuccessError_Model?)
}
class orderRatePresenter {
    
    let group = DispatchGroup()
    private let services: Services
    var error : Error?
    var result : SuccessError_Model?
    private weak var OrderRateViewDelegate: OrderRateViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setOrderRateViewDelegate(OrderRateViewDelegate: OrderRateViewDelegate) {
        self.OrderRateViewDelegate = OrderRateViewDelegate
    }
    func showIndicator() {
           SVProgressHUD.show()
       }
       func dismissIndicator() {
           SVProgressHUD.dismiss()
       }
    
    
    func postRateOrder(order_id: Int, rate: Double , driver_rate : Double , comment : String){
        
        group.enter()
        services.postRateOrder(order_id: order_id, order_rate: rate) {[weak self] (error: Error?, result: SuccessError_Model?) in
            
            self?.error = error
            self?.result = result
            self?.group.leave()
        }
        
        group.enter()
        postRateDriver(order_id: order_id, rate: driver_rate)
        
        group.enter()
        print(comment)
        postRateComment(order_id: order_id, comment: comment)
        
        group.notify(queue: .main) { [weak self] in
            
            self?.dismissIndicator()
            self?.OrderRateViewDelegate?.postRateResult(self?.error, self?.result)

        }
    }
    func postRateDriver(order_id: Int, rate: Double) {
        services.postRateDriver(order_id: order_id, rate: rate) {[weak self] (error: Error?, result: SuccessError_Model?) in
            
            self?.error = error
            self?.result = result

            self?.group.leave()
//            self?.OrderRateViewDelegate?.postRateDriverResult(error, result)
//            self?.dismissIndicator()
        }
    }
    func postRateComment(order_id: Int, comment: String){
        
        print(comment)
        services.postRateComment(order_id: order_id, comment: comment) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.error = error
            self?.result = result

//            self?.OrderRateViewDelegate?.postCommentRateResult(error, result)
//            self?.dismissIndicator()
            
            self?.group.leave()
        }
    }
}
