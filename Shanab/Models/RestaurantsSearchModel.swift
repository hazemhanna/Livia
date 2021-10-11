//
//  RestaurantsSearchModel.swift
//  Shanab
//
//  Created by Macbook on 6/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct RestaurantSearchModelModelJSON: Codable {
    var status: Bool?
    var data: RetaurantDataClass?
}

// MARK: - DataClass
struct RetaurantDataClass: Codable {
    var searchResult: [SearchResult]?
}

// MARK: - SearchResult
struct SearchResult: Codable {
    var id, userID, hasDelivery: Int?
    var type: String?
    var nameAr: String?
    var nameEn: String?
    var rate: Int?
    var longitude, latitude, address: String?
    var status: String?
    var image: String?
    var openDate, closeDate: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case hasDelivery = "has_delivery"
        case type
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case rate, longitude, latitude, address, status, image
        case openDate = "open_date"
        case closeDate = "close_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

