//
//  NotificationModel.swift
//  Shanab
//
//  Created by mahmoud helmy on 10/18/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Codable {
    var status: Bool?
    var data: NotificationData?
}

// MARK: - DataClass
struct  NotificationData: Codable {
    var notifications: [Notifications]?
}

// MARK: - Notification
struct Notifications: Codable {
    var id: Int?
    var userType, userID: String?
    var restaurantID: Int?
    var itemType: String?
    var itemID: Int?
    var body, title, url: String?
    var viewed, ajax: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case userID = "user_id"
        case restaurantID = "restaurant_id"
        case itemType = "item_type"
        case itemID = "item_id"
        case body, title, url
        case viewed = "Viewed"
        case ajax
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
