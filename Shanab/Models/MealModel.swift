//
//  MealModel.swift
//  Shanab
//
//  Created by Macbook on 4/16/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct RestaurantMealsModelJSON: Codable {
    var status: Bool?
    var data: MealsDataClass?
}

// MARK: - DataClass
struct MealsDataClass: Codable {
    var restaurantMeals: [RestaurantMeal]?
}

// MARK: - RestaurantMeal
struct RestaurantMeal: Codable {
    var id, restaurantID, categoryID, restaurantCategoryID: Int?
    var offerID: Int?
    var nameAr, nameEn, descriptionAr, descriptionEn: String?
    var points, rate: Int?
    var image: String?
    var calories: String?
    var status, createdAt, updatedAt: String?
    var discount : Double?
    //var restaurant_name_ar : String?
   // var restaurant_name_en : String?
    var favorite: [RestaurantsFavorite]?
    var price: [Price]?
    var collection: [Collection]?

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case categoryID = "category_id"
        case restaurantCategoryID = "restaurant_category_id"
        case offerID = "offer_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case descriptionAr = "description_ar"
        case descriptionEn = "description_en"
        case points, rate, image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case discount
        case calories
        case favorite
        case price
    }
}

// MARK: - Favorite

//    enum CodingKeys: String, CodingKey {
//        case id
//        case itemID = "item_id"
//        case itemType = "item_type"
//        case clientID = "client_id"
//        case deviceToken = "device_token"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//
