//
//  CatgeoriesModel.swift
//  Shanab
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct AllCatgeoriesModelJSON: Codable {
    var status: Bool?
    var data: OrderListDataClass?
}

// MARK: - DataClass
struct OrderListDataClass: Codable {
    var categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    var id, restaurantID: Int?
    var nameAr, nameEn: String?
    var image: String?
    var createdAt, updatedAt: String?
     var NameSelected: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
      case NameSelected
    }
}


