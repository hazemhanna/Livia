//
//  OnlineCartModel.swift
//  Shanab
//
//  Created by Macbook on 04/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct OnlineCartModelJSON: Codable {
    var status: Bool?
    var data: OnlinetDataClass?
}

// MARK: - DataClass
struct OnlinetDataClass: Codable {
    var cart: [onlineCart]?
    var vat: String?
    var fee: FeeValue?

}



enum FeeValue: Codable {
    case int(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .int(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(FeeValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct onlineCart: Codable {
    var id, mealID, clientID: Int?
       var message: String?
       var quantity: Int?
       var createdAt, updatedAt: String?
       var meal: Meal?
       var optionsContainer: [OptionsContainer]?
     
    enum CodingKeys: String, CodingKey {
        case id
               case mealID = "meal_id"
               case clientID = "client_id"
               case message, quantity
               case createdAt = "created_at"
               case updatedAt = "updated_at"
               case meal
               case optionsContainer = "options_container"
               //case vat, fee
    }
}

// MARK: - Meal
//struct Meal: Codable {
//    var id, restaurantID, categoryID, restaurantCategoryID: Int?
//    var offerID: Int?
//    var nameAr, nameEn, descriptionAr, descriptionEn: String?
//    var points, rate: Int?
//    var image: String?
//    var status, createdAt, updatedAt: String?
//    var price: [Price]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case restaurantID = "restaurant_id"
//        case categoryID = "category_id"
//        case restaurantCategoryID = "restaurant_category_id"
//        case offerID = "offer_id"
//        case nameAr = "name_ar"
//        case nameEn = "name_en"
//        case descriptionAr = "description_ar"
//        case descriptionEn = "description_en"
//        case points, rate, image, status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case price
//    }
//}

// MARK: - Price
//struct Price: Codable {
//    var id, currencyID, mealID, optionID: Int?
//    var price: Double?
//    var createdAt, updatedAt: String?
//    var currency: Currency?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case currencyID = "currency_id"
//        case mealID = "meal_id"
//        case optionID = "option_id"
//        case price
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case currency
//    }
//}



// MARK: - OptionsContainer
struct OptionsContainer: Codable {
    var id, collectionOptionID, cartID , quantity: Int?
       var createdAt, updatedAt: String?
       var options: Options?

    enum CodingKeys: String, CodingKey {
        case id
        case collectionOptionID = "collection_option_id"
        case cartID = "cart_id"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case options
    }
}

// MARK: - Options
//struct Options: Codable {
//    var id: Int?
//    var nameAr, nameEn: String?
//    var collectionID: Int?
//    var createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case nameAr = "name_ar"
//        case nameEn = "name_en"
//        case collectionID = "collection_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}







// MARK: - Offer
struct Offer: Codable {
    var id, restaurantID: Int?
       var nameAr, nameEn: String?
       var discount: Int?
       var discountType, startDate, endDate, curr: String?
       var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
               case restaurantID = "restaurant_id"
               case nameAr = "name_ar"
               case nameEn = "name_en"
               case discount
               case discountType = "discount_type"
               case startDate = "start_date"
               case endDate = "end_date"
               case curr
               case createdAt = "created_at"
               case updatedAt = "updated_at"
    }
}

// MARK: - CurrencyClass
struct CurrencyClass: Codable {
    var id: Int?
    var nameAr: String?
    var nameEn: String?

}




