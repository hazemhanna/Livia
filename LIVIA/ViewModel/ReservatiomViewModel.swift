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
    
    func getReservatiom() -> Observable<ReservationModelJSON> {
        let observer = GetServices.shared.getReservation()
        return observer
    }
    
    func cancelReservatiom(id : Int) -> Observable<BaseModel> {
        let observer = AddServices.shared.cancelReservation(id: id)
        return observer
    }
    
    func createReservatiom(table_number : String,reservation_date : String,notes : String,type:String,time_from : String) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "table_number": table_number,
            "reservation_date": reservation_date,
            "notes" : notes,
            "type" :type,
            "time_from" :time_from]
       let observer = AddServices.shared.createReservation(params: params)
       return observer
    }
    
}
