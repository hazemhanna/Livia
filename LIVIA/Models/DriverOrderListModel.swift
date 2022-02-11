//
//  DriverOrderListModel.swift
//  Shanab
//
//  Created by Macbook on 6/21/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct DriverOrderListModelJSON: Codable {
    var status: Bool?
    var data: UserAuthuDataClass?
    var errors: OrdersErrors?
}

// MARK: - DataClass
struct UserAuthuDataClass: Codable {
   
        var orders: OrderListPagination?
}
struct OrdersErrors: Codable {
    var account: String?
}

struct OrderListPagination : Codable {
        var currentPage: Int?
        var firstPageURL: String?
        var from, lastPage: Int?
        var lastPageURL, nextPageURL, path: String?
        var perPage: Int?
        var prevPageURL: String?
        var to: Int?
        var order : [OrderList]?
    
}
// MARK: - Order
struct OrderList: Codable {
   var id, clientID, driverID, addressID: Int?
    var currency: String?
    var total: Double?
    var status, lat, long: String?
    var quantity, rate: Int?
    var message: String?
    var createdAt, updatedAt: String?
    var client: Client?
    var orderDetail: [OrderDetail]?
    var address: Address?

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case currency, total, status, lat, long, quantity, rate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case client
        case orderDetail = "order_detail"
    }
}

// MARK: - Client
struct Client: Codable {
    var id, userID: Int?
    var nameAr, nameEn, image, phone: String?
    var address: String?
    var longitude, latitude: Int?
    var status: String?
    var user : Personal?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case image, phone, address, longitude, latitude, status , user
    }
}

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case categoryID = "category_id"
        case restaurantCategoryID = "restaurant_category_id"
        case offerID = "offer_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case descriptionAr = "description_ar"
        case descriptionEn = "description_en"
        case points, rate, image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case price, restaurant
    }


// MARK: - Currency
struct Currency: Codable {
    var id: Int?
    var nameAr, nameEn: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
    }
}
