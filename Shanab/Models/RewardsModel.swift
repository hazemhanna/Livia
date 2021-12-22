//
//  RewardsModel.swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import Foundation

// MARK: - RewardsModelJSON
struct RewardsModelJSON: Codable {
    let status: Bool?
    let data: RewardsModel?
}

// MARK: - DataClass
struct RewardsModel : Codable {
    let rewards: [Reward]?
}

// MARK: - Reward
struct Reward: Codable {
    let id, userID: Int?
    let titleAr, titleEn: String?
    let value: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case titleAr = "title_ar"
        case titleEn = "title_en"
        case value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct RefundModelJSON: Codable {
    var status: Bool?
    var message: String?
}


struct OrderPaymentModelJSON: Codable {
    var status: Bool?
    var message: String?
    var errors: String?
}

