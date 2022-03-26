//
//  HomeModel.swift
//  Livia
//
//  Created by MAC on 26/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct SliderModelJson: Codable {
    let value: Bool?
    let data: SliderModel?
    let msg: String?
}

struct SliderModel: Codable {
    let sliders: [Slider]?
}

struct Slider: Codable {
    let id: Int?
    let status: String?
    let image: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, status, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

