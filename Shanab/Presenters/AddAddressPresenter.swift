//
//  AddAddressPresenter.swift
//  Shanab
//
//  Created by Macbook on 21/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol AddAddressViewDelegate: class {
    func postAddAddress(_ error: Error?, _ result: SuccessError_Model?)
    func postGetCountries(_ error: Error?, _ result: [Country]?)
    func postGetCitiesAndAries(_ error: Error?, _ result: [Country]?)
    func postGetAries(_ error: Error?, _ result: [Country]?)
}
class AddAddressPresenter {
    private let services: Services
    private weak var AddAddressViewDelegate: AddAddressViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setAddAddressViewDelegate(AddAddressViewDelegate: AddAddressViewDelegate) {
        self.AddAddressViewDelegate = AddAddressViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postAddAddress(lat: Double, long: Double, address: String, floor: Int,country_id: Int, city_id: Int, area_id: Int, building: Int, apartment: Int) {
           services.postAddAddress(lat: lat, long: long, address: address, floor: floor, country_id: country_id, city_id: city_id, area_id: area_id, building: building, apartment: apartment) { [weak self](error: Error?, result: SuccessError_Model?) in
            
            self?.dismissIndicator()
               self?.AddAddressViewDelegate?.postAddAddress(error, result)
           }
       }
    
    
    func postGetCitiesAndAries(table: String, condition: String, id: Int) {
        services.postGetCities(table: table, condition: condition, id: id) {[weak self] (error: Error?, result: [Country]?) in
            self?.AddAddressViewDelegate?.postGetCitiesAndAries(error, result)
            self?.dismissIndicator()
        }
          
    }
    func postGetCountries(table: String) {
           services.postGetCountries(table: table) {[weak self] (error: Error?, result: [Country]?) in
               self?.AddAddressViewDelegate?.postGetCountries(error, result)
               self?.dismissIndicator()
           }
       }
    func postGetAries(table: String, condition: String, id: Int) {
        services.postGetCities(table: table, condition: condition, id: id) {[weak self] (error: Error?, result: [Country]?) in
            self?.AddAddressViewDelegate?.postGetAries(error, result)
            self?.dismissIndicator()
        }
          
    }
}
