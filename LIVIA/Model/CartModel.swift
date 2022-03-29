//
//  CartModel.swift
//  Livia
//
//  Created by MAC on 28/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

// MARK: - CartModel
struct CartModelJson : Codable {
    let value: Bool?
    let data: CartModel?
    let msg: String?
}

// MARK: - DataClass
struct CartModel: Codable {
    let cart: [Cart]?
}

// MARK: - Cart
struct Cart: Codable {
    let id: Int?
    let product: Product?
    let productVariant: Variant?
    let price: String?
    let quantity: Int?

    enum CodingKeys: String, CodingKey {
        case id, product
        case productVariant = "product_variant"
        case price, quantity
    }
}
