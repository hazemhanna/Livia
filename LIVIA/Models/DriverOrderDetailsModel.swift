//
//  DriverOrderDetailsModel.swift
//  Shanab
//
//  Created by Macbook on 6/28/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct DriverOrderDetalilsModelJSON: Codable {
    var status: Bool?
    var data: DriverDetailsDataClass?
}

// MARK: - DataClass
struct DriverDetailsDataClass: Codable {
    var driverOrder: [DriverOrder]?
    var userOrder: [DriverOrder]?
}

// MARK: - Order
struct DriverOrder: Codable {
    var id, clientID, driverID: Int?
    var currency: String?
    var total: Double?
    var status, lat, long: String?
    var quantity, rate : Int?
    var driver_rate: Double?
    
    
    var type, createdAt, updatedAt: String?
    var approved : Int?
    var client: Client?
    var orderDetail: [OrderDetail]?
    var address : AddressClass?

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case currency, total, status, lat, long, quantity, rate , driver_rate, approved
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type, client
        case orderDetail = "order_detail"
        case address
    }
}

