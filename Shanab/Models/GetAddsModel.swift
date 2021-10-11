//
//  GetAddsModel.swift
//  Shanab
//
//  Created by Macbook on 4/13/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct GetAddsModelJSON: Codable {
    var status: Bool?
    var data: GetAddsDataClass?
}

// MARK: - DataClass
struct GetAddsDataClass: Codable {
    var adds: [Add]?
}

// MARK: - Add
struct Add: Codable {
 var id: Int?
  var image, itemID, itemType: String?
  var viewOrder: Int?
  var startDate, endDate, createdAt, updatedAt: String?

  enum CodingKeys: String, CodingKey {
      case id, image
      case itemID = "item_id"
      case itemType = "item_type"
      case viewOrder = "view_order"
      case startDate = "start_date"
      case endDate = "end_date"
      case createdAt = "created_at"
      case updatedAt = "updated_at"
    }
}
