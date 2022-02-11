//
//  MealSearchModel.swift
//  Shanab
//
//  Created by Macbook on 6/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct MealDetailsModelJSON: Codable {
    var status: Bool?
    var data: CollectionDataClass?
}

// MARK: - DataClass
struct CollectionDataClass: Codable {
    var id, restaurantID, categoryID, restaurantCategoryID: Int?
    var offerID: Int?
    var nameAr, nameEn, descriptionAr, descriptionEn: String?
    var points, rate,discount: Int?
    var image: String?
    var status, calories , createdAt, updatedAt: String?
    var favorite : [Favorites]?
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
        case points, rate, image, status , calories
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case  favorite ,price, collection,discount
    }
}
// MARK: - Collection
struct Collection: Codable {
    var id, mealID: Int?
    var nameAr, nameEn, createdAt, updatedAt: String?
    var option: [Options]?

    enum CodingKeys: String, CodingKey {
        case id
        case mealID = "meal_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case option
    }
}


