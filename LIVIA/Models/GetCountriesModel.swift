//
//  GetCountriesModel.swift
//  Shanab
//
//  Created by Macbook on 21/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct GetCountriesModelJSON: Codable {
    var status: Bool?
    var data: OnlineCartDataClass?
}

// MARK: - DataClass
struct OnlineCartDataClass: Codable {
    var countries: [Country]?
}

// MARK: - Country
struct Country: Codable {
    var id: Int?
    var nameAr, nameEn: String?
    var countryID: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case countryID = "country_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}




