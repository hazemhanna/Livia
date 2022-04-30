//
//  OrderModel.swift
//  Livia
//
//  Created by MAC on 07/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct OrderModelJSON: Codable {
    let value: Bool?
    let data: OrderModel?
    let msg: String?
}

// MARK: - DataClass
struct OrderModel : Codable {
    let orders: [Order]?
    let paginate: Paginate?
}

// MARK: - Order
struct Order: Codable {
    let id: Int?
    let orderType, mobile, address, orderDate: String?
    let notes: String?
    let logs: [Log]?
    let orderItems: [OrderItem]?
    let delivery_price: String?
    let order_place: Int?
    let created_at: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderType = "order_type"
        case mobile, address
        case orderDate = "order_date"
        case notes, logs
        case orderItems = "order_items"
        case delivery_price = "fixed_delivery_price"
        case order_place = "order_place"
        case created_at = "created_at"
    }
}

// MARK: - Log
struct Log: Codable {
    let id: Int?
    let status: String?
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let id: Int?
    let notes: String?
    let price: String?
    let quantity: Int?
    let product: Product?
    let variant: Variant?
   // let collectionOptions: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, notes, price, quantity, product, variant
       // case collectionOptions = "collection_options"
    }
}
