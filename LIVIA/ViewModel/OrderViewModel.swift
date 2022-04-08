//
//  OrderViewModel.swift
//  Livia
//
//  Created by MAC on 07/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import RxSwift
import SVProgressHUD

struct OrderViewModel {
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getOrders() -> Observable<OrderModelJSON> {
        let observer = GetServices.shared.getOrders()
        return observer
    }
    
    func cancelOrder(order_id : Int) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "order_id": order_id]
        let observer = AddServices.shared.cancelOrder(params: params)
        return observer
    }
}
