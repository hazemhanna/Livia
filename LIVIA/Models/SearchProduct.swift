//
//  SearchProduct.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct SearchModelJSON: Codable {
    var status: Bool?
    var data: SearchModelDataClass?
}

// MARK: - DataClass
struct SearchModelDataClass: Codable {
    var offset: Int?
    var products: [SearchProduct]?
}

// MARK: - Product
struct SearchProduct: Codable {
    var id: Int?
    var name: String?
    var price, discount: Int?
    var productOneImage: ProductOneImage?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, discount
        case productOneImage = "product_one_image"
    }
}

// MARK: - ProductOneImage
struct ProductOneImage: Codable {
    var id, productID: Int?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case image
    }
}
