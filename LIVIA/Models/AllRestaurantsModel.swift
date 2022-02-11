//
//  AllRestaurantsModel.swift
//  Shanab
//
//  Created by Macbook on 4/13/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct AllRestaurantsModelJSON: Codable {
    var status: Bool?
    var data: AllRestaurantsDataClass?
}

// MARK: - DataClass
struct AllRestaurantsDataClass: Codable {
    var restaurants: [Restaurant]?
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id, userID, hasDelivery: Int?
    var type: String?
    var isAvailable: Int?
    var reservation: String?
    var reservationFee, deliveryTime : Int?
    var deliveryFee : Double?
    var minimum: Int?
    var points: Int?
    var nameAr, nameEn: String?
    var rate: Double?
    var longitude, latitude: String?
    var address: String?
    var status: String?
    var image: String?
    var logo: String?
    var documents, openDate, closeDate: String?
    var commission: Int?
    var commissionType: String?
    var commissionPeriod: String?
    var createdAt, updatedAt: String?
    var userRate: Int?
    var favorite: [Favorites]?
    
    enum CodingKeys: String, CodingKey {
               case id
               case userID = "user_id"
               case hasDelivery = "has_delivery"
               case type
               case isAvailable = "is_available"
               case reservation
               case reservationFee = "reservation_fee"
               case deliveryTime = "delivery_time"
               case deliveryFee = "delivery_fee"
               case minimum, points
               case nameAr = "name_ar"
               case nameEn = "name_en"
               case rate, longitude, latitude, address, status, image, logo, documents
               case openDate = "open_date"
               case closeDate = "close_date"
               case commission
               case commissionType = "commission_type"
               case commissionPeriod = "commission_period"
               case createdAt = "created_at"
               case updatedAt = "updated_at"
               case userRate = "user_rate"
               case favorite
    }
}

