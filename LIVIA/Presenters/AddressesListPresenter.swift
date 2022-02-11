//
//  AddressesListPresenter.swift
//  Shanab
//
//  Created by Macbook on 21/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol AddressesListViewDelegate: class {
    func getAddresses(_ error: Error?, _ adressList: [Address]?)
    func postDeleteAddress(_ error: Error?, _ result: SuccessError_Model?)
}
class AddressesListpresenter {
    private let services: Services
    private weak var AddressesListViewDelegate: AddressesListViewDelegate?
    init (services: Services) {
        self.services = services
    }
    func setAddressesListViewDelegate(AddressesListViewDelegate: AddressesListViewDelegate) {
        self.AddressesListViewDelegate = AddressesListViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getAddresses() {
        services.getAddresses { [weak self](error: Error?, addressList: [Address]?) in
            self?.AddressesListViewDelegate?.getAddresses(error, addressList)
            self?.dismissIndicator()
        }
    }
    func postDeleteAddress(id: Int) {
        services.postDeleteAddress(id: id) {[weak self] (error: Error?, result: SuccessError_Model?) in
            self?.AddressesListViewDelegate?.postDeleteAddress(error, result)
            self?.dismissIndicator()
        }
    }
}
