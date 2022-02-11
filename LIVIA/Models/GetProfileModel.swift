//
//  UserProfileModel.swift
//  Shanab
//
//  Created by Macbook on 6/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct GetProfileModelModelJSON: Codable {
    var status: Bool?
    var data: MealDataClass?
}

// MARK: - DataClass
struct MealDataClass: Codable {
    var user: User?
}

// MARK: - User
struct User: Codable {
    var id, userID: Int?
    var nameAr, nameEn, image, images, phone: String?
    var address: String?
    var longitude, latitude: String?
    var status: String?
    var personal: Personal?
    var  is_available: Int?
    var total_wallet : Double?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case image,images, phone, address, longitude, latitude, status, personal, is_available,total_wallet
    }
}

// MARK: - Personal
struct Personal: Codable {
    var id: Int?
    var name, email, phone, emailVerifiedAt: String?
    var androidToken, iosToken, type, createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case emailVerifiedAt = "email_verified_at"
        case androidToken = "android_token"
        case iosToken = "ios_token"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
