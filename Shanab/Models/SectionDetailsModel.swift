//
//  SectionDetailsModel.swift
//  Shanab
//
//  Created by mac on 2/21/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//


import Foundation
// MARK: - MealDetailsJSONModel
struct SectionDetailsJSONModel: Codable {
    var status: Bool?
    var data: sectionsDetailsDataClass?
}

// MARK: - DataClass
struct sectionsDetailsDataClass: Codable {
    var meals: [sectionMeal]?
}

// MARK: - Meal
struct sectionMeal: Codable {
    var id, restaurantID, categoryID, restaurantCategoryID: Int?
       var offerID: Int?
       var nameAr, nameEn, descriptionAr, descriptionEn: String?
       var points, rate: Int?
       var image, status, calories, createdAt: String?
       var updatedAt: String?
       var hasOffer: Int?
       var discount: Int?
       var discountType: String?
       var restaurantNameAr, restaurantNameEn: String?
       var favorite: [Favorites]?
       var price: [Price]?
       var offer: Offer?
       var restaurant: Restaurant?
    
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
               case points, rate, image, status, calories
               case createdAt = "created_at"
               case updatedAt = "updated_at"
               case hasOffer = "has_offer"
               case discount
               case discountType = "discount_type"
               case restaurantNameAr = "restaurant_name_ar"
               case restaurantNameEn = "restaurant_name_en"
               case favorite, price, offer, restaurant
    }
}


