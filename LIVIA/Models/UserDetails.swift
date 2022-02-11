//
//  UserDetails.swift
//  Shanab
//
//  Created by Macbook on 17/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct UserDetailsModelJSON: Codable {
    var status: Bool?
    var data: SectionsDetailsDataClass?
}

// MARK: - DataClass
struct SectionsDetailsDataClass: Codable {
    var orderDetails: [OrderDetails]?
}

// MARK: - Order
struct OrderDetails: Codable {
    var id, clientID, driverID, addressID: Int?
    var currency: String?
    var total: Int?
    var status, lat, long: String?
    var quantity, rate: Int?
    var message, createdAt, updatedAt: String?
    var orderDetail: [orderDetail]?

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case addressID = "address_id"
        case currency, total, status, lat, long, quantity, rate, message
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderDetail = "order_detail"
    }
}

// MARK: - OrderDetail
struct orderDetail: Codable {
    var id, orderID, mealID: Int?
    var status: String?
    var quantity, price, offerID, restaurantID: Int?
    var message, createdAt, updatedAt: String?
    var option: [Option]?
    var meal: Meal?
    var restaurant: Restaurant?

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case mealID = "meal_id"
        case status, quantity, price
        case offerID = "offer_id"
        case restaurantID = "restaurant_id"
        case message
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case option, meal, restaurant
    }
}

