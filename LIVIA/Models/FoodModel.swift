//
//  FoodModel.swift
//  Shanab
//
//  Created by MAC on 08/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import Foundation

// MARK: - FoodPackegeModelJSON
struct FoodPackegeModelJSON: Codable {
    let status: Bool?
    let data: FoodPackegeModel?
}

// MARK: - DataClass
struct FoodPackegeModel : Codable {
    let foodSubscriptions: [FoodSubscription]?

    enum CodingKeys: String, CodingKey {
        case foodSubscriptions = "food_subscriptions"
    }
}

// MARK: - FoodSubscription
struct FoodSubscription: Codable {
    let id, restaurantID, subscriptionID: Int?
    let titleAr, titleEn, descriptionEn, descriptionAr: String?
    let price: Int?
    let image: String?
    let createdAt, updatedAt: String?
    let subscription: Subscription?
    let available_to: String?
    let days: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case subscriptionID = "subscription_id"
        case titleAr = "title_ar"
        case titleEn = "title_en"
        case descriptionEn = "description_en"
        case descriptionAr = "description_ar"
        case price, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subscription,available_to,days
    }
}


// MARK: - ApplyFoodPackegeModelJSON
struct ApplyFoodPackegeModelJSON: Codable {
    let status: Bool?
    let data: ApplyFoodPackegeModel?
}

// MARK: - DataClass
struct ApplyFoodPackegeModel: Codable {
    let subscription: ApplyFoodPackege?
}

// MARK: - Subscription
struct ApplyFoodPackege : Codable {
    let userID: Int?
    let restaurantID, foodSubscriptionID: String?
    let days: Int?
    let hasDeliverySubscription, deliveryPrice, foodPrice, total: String?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case restaurantID = "restaurant_id"
        case foodSubscriptionID = "food_subscription_id"
        case days
        case hasDeliverySubscription = "has_delivery_subscription"
        case deliveryPrice = "delivery_price"
        case foodPrice = "food_price"
        case total
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}


// MARK: - AddFoodPackegeToCartModelJSON
struct AddFoodPackegeToCartModelJSON: Codable {
    let status: Bool?
    let data: AddFoodPackegeToCartModel?
}

// MARK: - DataClass
struct AddFoodPackegeToCartModel: Codable {
    let foodCart: AddFoodPackegeToCart?

    enum CodingKeys: String, CodingKey {
        case foodCart = "food_cart"
    }
}

//// MARK: - FoodCart
struct AddFoodPackegeToCart : Codable {
    //let userID: Int?
    //let restaurantID, foodSubscriptionID: String?
  //  let days: Int?
//    let hasDeliverySubscription, deliveryPrice, foodPrice, total: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case restaurantID = "restaurant_id"
//        case foodSubscriptionID = "food_subscription_id"
//        case days
//        case hasDeliverySubscription = "has_delivery_subscription"
//        case deliveryPrice = "delivery_price"
//        case foodPrice = "food_price"
//        case total
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}



// MARK: - MyFoodSubscribtionModelJSON
struct MyFoodSubscribtionModelJSON: Codable {
    let status: Bool?
    let data: MyFoodSubscribtionModel?
}

// MARK: - DataClass
struct MyFoodSubscribtionModel: Codable {
    let subscriptions: [MyFoodSubscribtion]?
}

// MARK: - SubscriptionElement
struct MyFoodSubscribtion : Codable {
    let id, foodSubscriptionID, restaurantID, hasDeliverySubscription: Int?
    let deliveryPrice: Int?
    let foodPrice, total: Double?
    let userID, days: Int?
    let createdAt, updatedAt: String?
    let restaurant: Restaurant?
    let foodSubscription: FoodSubscription?

    enum CodingKeys: String, CodingKey {
        case id
        case foodSubscriptionID = "food_subscription_id"
        case restaurantID = "restaurant_id"
        case hasDeliverySubscription = "has_delivery_subscription"
        case deliveryPrice = "delivery_price"
        case foodPrice = "food_price"
        case total
        case userID = "user_id"
        case days
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case restaurant
        case foodSubscription = "food_subscription"
    }
}


// MARK: - MyCartFoodSubscribtionModelJSON
struct MyCartFoodSubscribtionModelJSON: Codable {
    let status: Bool?
    let data: MyCartFoodSubscribtionModl?
}

// MARK: - DataClass
struct MyCartFoodSubscribtionModl: Codable {
    let foodCarts: [FoodCart]?

    enum CodingKeys: String, CodingKey {
        case foodCarts = "food_carts"
    }
}

// MARK: - FoodCart
struct FoodCart: Codable {
    let id, foodSubscriptionID, restaurantID, hasDeliverySubscription: Int?
    let deliveryPrice: Int?
    let foodPrice, total: Double?
    let userID, days: Int?
    let createdAt, updatedAt: String?
    let restaurant: Restaurant?
    let foodSubscription: FoodSubscription?

    enum CodingKeys: String, CodingKey {
        case id
        case foodSubscriptionID = "food_subscription_id"
        case restaurantID = "restaurant_id"
        case hasDeliverySubscription = "has_delivery_subscription"
        case deliveryPrice = "delivery_price"
        case foodPrice = "food_price"
        case total
        case userID = "user_id"
        case days
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case restaurant
        case foodSubscription = "food_subscription"
    }
}
