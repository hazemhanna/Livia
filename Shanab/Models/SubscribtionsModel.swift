//
//  SubscribtionsModel.swift
//  Shanab
//
//  Created by MAC on 29/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import Foundation

struct subscriptionModelJSON: Codable {
    let status: Bool?
    let data: SubscriptionModel?
}

// MARK: - DataClass
struct SubscriptionModel: Codable {
    let subscriptions: [Subscription]?
}

// MARK: - Subscription
struct Subscription: Codable {
    let id: Int?
    let titleAr, titleEn: String?
    let price, days: Int?
    let status: String?
    let deleted: Int?
    let available_to: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case titleAr = "title_ar"
        case titleEn = "title_en"
        case price, days, status, deleted,available_to
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct MySubscriptionsModelJason: Codable {
    let status: Bool?
    let data: MySubscriptionsModel?
}

// MARK: - DataClass
struct MySubscriptionsModel: Codable {
    let subscriptions: [SubscriptionElement]?
}

// MARK: - SubscriptionElement
struct SubscriptionElement: Codable {
    let id, userID, restaurantID, subscriptionID: Int?
    let status: String?
    let days: Int?
    let createdAt, updatedAt: String?
    let restaurant: Restaurant?
    let subscription: Subscription?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case restaurantID = "restaurant_id"
        case subscriptionID = "subscription_id"
        case status, days
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case restaurant, subscription
    }
}

//
struct ApplyingSubscribtionModelJSON: Codable {
    let status: Bool?
    let data: ApplyingSubscribtionModel?
}

// MARK: - DataClass
struct ApplyingSubscribtionModel : Codable {
    let subscription: ApplyingSubscribtion?
}

// MARK: - Subscription
struct ApplyingSubscribtion: Codable {
    let restaurantID, days, id: Int?
    let createdAt: String?
    let userID, subscriptionID: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case days, id
        case createdAt = "created_at"
        case userID = "user_id"
        case subscriptionID = "subscription_id"
        case updatedAt = "updated_at"
    }
}

