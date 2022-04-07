//
//  AfaqModelsJSON.swift
//  Livia
//
//  Created by MAC on 22/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct RegisterModel:  Codable {
    let value: Bool?
    let user: UserModel?
    let msg: Errors?
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case value, user, msg
        case token = "access_token"
    }
}

struct LoginModel:  Codable {
    let value: Bool?
    let user: UserModel?
    let msg: String?
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case value, user, msg
        case token = "access_token"
    }
}

// MARK: - DataClass
struct UserModel: Codable {
    let id: Int?
    let name, email, address, phone: String?
  //  let verificationCode: Int?
    let isVerified: Int?
    let role, status, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, address, phone
       // case verificationCode = "verification_code"
        case isVerified = "is_verified"
        case role, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - ProfileModel
struct ProfileModel:  Codable {
    var value: Bool?
    let data: UserModel?
    var msg: String?
}


struct SettingModelJson : Codable {
    let value: Bool?
    let data: SettingModel
    let msg: String?
}

struct SettingModel: Codable {
    let settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    let applicationName, aboutUs, terms: Title?
    let applicationEmail: String?
    let facebook, snapshat, whatsapp, twitter: String?
    let freeDeliveryProduct: Int?
    let deliveryTax: String?
    let maxMinCancelOrder: Int?

    enum CodingKeys: String, CodingKey {
        case applicationName = "application_name"
        case aboutUs = "about_us"
        case terms
        case applicationEmail = "application_email"
        case facebook, snapshat, whatsapp, twitter
        case freeDeliveryProduct = "free_delivery_product"
        case deliveryTax = "delivery_tax"
        case maxMinCancelOrder = "max_min_cancel_order"
    }
}
