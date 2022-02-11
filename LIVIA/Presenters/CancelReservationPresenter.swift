//
//  CancelReservationPresenter.swift
//  Shanab
//
//  Created by Macbook on 12/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol CancelReservationViewDelegate: class {
    func CancelReservationResult(_ error: Error?, _ reservation: SuccessError_Model?)
    func ReservationDetailsResult(_ error: Error?, _ details: DetailsDataClass?)

}
class CancelReservationPresenter {
    private let services: Services
       private weak var CancelReservationViewDelegate: CancelReservationViewDelegate?
       init(services: Services) {
           self.services = services
}
    func setCancelReservationViewDelegate(CancelReservationViewDelegate: CancelReservationViewDelegate) {
        self.CancelReservationViewDelegate = CancelReservationViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postCancelReservation(id: Int) {
           services.postCancelReservation(id: id) {[weak self] (error: Error?, reservation: SuccessError_Model?) in
               self?.CancelReservationViewDelegate?.CancelReservationResult(error, reservation)
               self?.dismissIndicator()
           }
       }
    
    func postReservationDetailsResult(id: Int) {
        services.postReservationDetails(id: id) {[weak self] (error: Error?, details: DetailsDataClass?) in
            self?.CancelReservationViewDelegate?.ReservationDetailsResult(error, details)
            self?.dismissIndicator()
        }
    }
}
