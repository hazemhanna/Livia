//
//  CategoriesModel.swift
//  Livia
//
//  Created by MAC on 26/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct CategoriesModelJson: Codable {
    let value: Bool?
    let data: CategoriesModel?
    let msg: String?
}

struct CategoriesModel: Codable {
    let categories: [Category]?
}

struct Category: Codable {
    let id: Int?
    let title: Title?
    let image: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Title: Codable {
    let en, ar: String?
}
