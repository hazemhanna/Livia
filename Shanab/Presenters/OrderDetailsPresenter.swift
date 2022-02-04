//
//  OrderDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 5/21/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol DriverOrderDetailsViewDelegate: class {
    func DriverOrderDetailsResult(_ error: Error?, _ details: [DriverOrder]?)
     func DriverChangeStatusResult(_ error: Error?, _ result: SuccessError_Model?)
     func getDriverProfileResult(_ error: Error?, _ result: User?)
    func getCartResult(_ error: Error?, _ result: String?)
    func postDriverRejactOrderResult(_ error: Error?, _ result: SuccessError_Model?)
    func getWebView(_ error: Error?, _ result: WebViewModel?)
}

class DriverOrderDetailsPresenter {
    private let services: Services
    private weak var DriverOrderDetailsViewDelegate: DriverOrderDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setDriverOrderDetailsViewDelegate(DriverOrderDetailsViewDelegate: DriverOrderDetailsViewDelegate) {
        self.DriverOrderDetailsViewDelegate = DriverOrderDetailsViewDelegate
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
    func getDriverOrderDetails(id: Int) {
        services.postDriverOrderDetails(id: id) {[weak self] (error: Error?, details: [DriverOrder]?) in
            self?.DriverOrderDetailsViewDelegate?.DriverOrderDetailsResult(error, details)
            self?.dismissIndicator()
        }
    }
    func DriverChangeStatus(id: Int , status : String) {
        services.postDriverChangeOrderStatus(id: id , status : status) {[weak self] (error: Error?, result: SuccessError_Model?) in
               self?.DriverOrderDetailsViewDelegate?.DriverChangeStatusResult(error, result)
               self?.dismissIndicator()
           }
       }
    func getDriverProfile() {
          services.getDriverProfile { [weak self](error: Error?, result: User?) in
              self?.DriverOrderDetailsViewDelegate?.getDriverProfileResult(error, result)
              self?.dismissIndicator()
          }
      }
    
    func getCartItems() {
        services.getCartItems {[weak self] (error: Error?, result: OnlinetDataClass?) in
            self?.DriverOrderDetailsViewDelegate?.getCartResult(error, result?.vat)
            self?.dismissIndicator()
        }
    }
    
    
    func postWorkerCancelOrder(order_id: Int , status: String) {
        services.posDriverRejactedOrder(order_id: order_id, status: status) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.showIndicator()
            self?.DriverOrderDetailsViewDelegate?.postDriverRejactOrderResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getWebView(order_id : Int) {
           services.getWebViewLink(order_id : order_id) {[weak self] (error: Error?, result: WebViewModel?) in
            self?.DriverOrderDetailsViewDelegate?.getWebView(error, result)
               self?.dismissIndicator()
           }
       }
}
