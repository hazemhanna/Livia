//
//  ReservationDetailsPresenter.swift
//  Shanab
//
//  Created by Macbook on 6/8/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol ReservationDetailsViewDelegate: class {
    func ReservationDetailsResult(_ error: Error?, _ details: DetailsDataClass?)
}
class ResevationDetailsPresenter {
    private let services: Services
    private weak var ReservationDetailsViewDelegate: ReservationDetailsViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setReservationDetailsViewDelegate(ReservationDetailsViewDelegate: ReservationDetailsViewDelegate) {
        self.ReservationDetailsViewDelegate = ReservationDetailsViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postReservationDetailsResult(id: Int) {
        services.postReservationDetails(id: id) {[weak self] (error: Error?, details: DetailsDataClass?) in
            self?.ReservationDetailsViewDelegate?.ReservationDetailsResult(error, details)
            self?.dismissIndicator()
        }
    }
}
