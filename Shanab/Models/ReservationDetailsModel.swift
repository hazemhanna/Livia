//
//  ReservationDetailsModel.swift
//  Shanab
//
//  Created by Macbook on 6/8/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct ReservationDetailstModelJSON: Codable {
    var status: Bool?
    var data: DetailsDataClass?
    
}

// MARK: - DataClass
struct DetailsDataClass: Codable {
    var id, clientID, restaurantID: Int?
    var numberOfPersons, date, time: String?
    var cancelation: Int?
    var createdAt, updatedAt: String?
    var restaurant: Restaurant?

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case restaurantID = "restaurant_id"
        case numberOfPersons = "number_of_persons"
        case date, time, cancelation
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case restaurant
    }
}

