//
//  SettingsModel.swift
//  Shanab
//
//  Created by Macbook on 4/16/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct SettingModelJSON: Codable {
    var status: Bool?
    var data: SettingsDataClass?
}

// MARK: - DataClass
struct SettingsDataClass: Codable {
    var settings: [Setting]?
}

// MARK: - Setting
struct Setting: Codable {
    var id: Int?
    var key: String?
    var valueAr, valueEn: String?
    var createdAt, updatedAt: String?
     var SettingImage: Data?

    enum CodingKeys: String, CodingKey {
        case id, key
        case valueAr = "value_ar"
        case valueEn = "value_en"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case SettingImage
    }
}
