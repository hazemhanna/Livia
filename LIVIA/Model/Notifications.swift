//
//  File.swift
//  Livia
//
//  Created by MAC on 30/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import Foundation

// MARK: - NotificationModelJSON
struct NotificationModelJSON: Codable {
    let value: Bool?
    let data: NotificationModelJSONData?
    let msg: String?
}

// MARK: - NotificationModelJSONData
struct NotificationModelJSONData: Codable {
    let notifications: [Notifications]?
    let paginate: Paginate?
}

// MARK: - Notification
struct Notifications: Codable {
    let id: String?
    let data: NotificationData?
    let readAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, data
        case readAt = "read_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - NotificationData
struct NotificationData: Codable {
    let name: Title?
    let body: Body?
}

// MARK: - Body
struct Body: Codable {
    let ar: String?
    let en: String?
    let type: String?
    let id: Int?
    let url: String?
}
