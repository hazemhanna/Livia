//
//  ReservationPresenter.swift
//  Shanab
//
//  Created by Macbook on 5/28/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol CreateReservationViewDelegate: class {
    func CreateReservationResult(_ error: Error?, _ result: SuccessError_Model?)
//    func CancelReservationResult(_ error: Error?, _ reservation: SuccessError_Model?)
}
class CreateReservationPresenter {
    private let services: Services
    private weak var CreateReservationViewDelegate: CreateReservationViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setCreateReservationViewDelegate(CreateReservationViewDelegate: CreateReservationViewDelegate) {
        self.CreateReservationViewDelegate = CreateReservationViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postCreateReservation(restaurant_id: Int, number_of_persons: Int, date: String, time: String, price: Int ,position : String) {
        services.postCreateReservation(restaurant_id: restaurant_id, number_of_persons: number_of_persons, date: date, time: time, price: price ,position : position) { [weak self](_ error: Error?, _ result: SuccessError_Model?) in
            self?.CreateReservationViewDelegate?.CreateReservationResult(error, result)
            self?.dismissIndicator()
        }
    }
//    func postCancelReservation(id: Int) {
//              services.postCancelReservation(id: id) {[weak self] (error: Error?, reservation: SuccessError_Model?) in
//                  self?.CreateReservationViewDelegate?.CancelReservationResult(error, reservation)
//                  self?.dismissIndicator()
//              }
//          }
}
