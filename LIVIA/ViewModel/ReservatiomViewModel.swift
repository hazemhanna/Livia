//
//  ReservatiomViewModel.swift
//  Livia
//
//  Created by MAC on 07/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import Foundation
import RxSwift
import SVProgressHUD

struct ReservatiomViewModel {
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getReservatiom() -> Observable<OrderModelJSON> {
        let observer = GetServices.shared.getOrders()
        return observer
    }
    
    func cancelReservatiom(order_id : Int) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "order_id": order_id]
        let observer = AddServices.shared.cancelOrder(params: params)
        return observer
    }
    func createReservatiom(table_number : String,reservation_date : String,notes : String,type:String,time_from : String) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "table_number": table_number,
            "reservation_date": reservation_date,
            "notes" : notes,
            "type" :type,
            "time_from" :time_from]
       let observer = AddServices.shared.createOrder(params: params)
       return observer
    }
}
