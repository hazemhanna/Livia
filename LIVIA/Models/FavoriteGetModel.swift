//
//  FavoriteGetModel.swift
//  Shanab
//
//  Created by Macbook on 5/21/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct FavoritesModelJSON: Codable {
    var status: Bool?
    var data: FavoriteDataClass?
}
struct FavoriteDataClass: Codable {
    var favorite: [Favorites]?
}



// MARK: - Datum
struct Favorites: Codable {
   var id, itemID: Int?
    var itemType: String?
    var clientID: Int?
    var deviceToken, createdAt, updatedAt: String?
    var meal: Meal?
    var restaurant: Restaurant?
    
    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case itemType = "item_type"
        case clientID = "client_id"
        case deviceToken = "device_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case restaurant
        case meal
    }
}

// MARK: - Restaurant
struct restaurant: Codable {
    var id, restaurantID, categoryID, restaurantCategoryID: Int?
    var offerID: Int?
    var nameAr, nameEn, descriptionAr, descriptionEn: String?
    var points : Int?
    var rate: Double?
    var image: String?
    var status, createdAt, updatedAt: String?
    
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
    }
}
