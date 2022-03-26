//
//  ProducrModel.swift
//  Livia
//
//  Created by MAC on 26/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct ProductModelJson : Codable {
    let value: Bool?
    let data: ProductModel?
    let msg: String?
}

struct ProductModel: Codable {
    let products: [Product]?
    let paginate: Paginate?
}

struct Paginate: Codable {
    let total, lastPage, count, perPage: Int?
    let nextPageURL, prevPageURL: Int?
    let currentPage, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case lastPage = "last_page"
        case count
        case perPage = "per_page"
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

struct Product: Codable {
    
    let id: Int?
    let type: String?
    let title, desc: Title?
    let discount: String?
    let category: Category?
    let images: [Category]?
    let variants: [Variant]?
    let productCollections: [ProductCollection]?
    let isWishlist: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, type, title, desc, discount, category
        case images = "images   "
        case variants
        case productCollections = "product_collections"
        case isWishlist = "is_wishlist"

    }
}

struct ProductCollection: Codable {
    let id: Int?
    let name: String?
    let options: [Option]?
}

struct Option: Codable {
    let id, collectionID: Int?
    let name: String?
    let price, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case collectionID = "collection_id"
        case name, price
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Variant: Codable {
    let id: Int?
    let productSize, price: String?
    let quantity, quantityOrdered: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productSize = "product_size"
        case price, quantity
        case quantityOrdered = "quantity_ordered"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
