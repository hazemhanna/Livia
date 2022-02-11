//
//  SearchInMealsModel.swift
//  Shanab
//
//  Created by Macbook on 31/08/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct MealSearchModelJSON: Codable {
    var status: Bool?
    var data: DataCalss?
}

struct DataCalss: Codable {
    var searchResult: [CollectionDataClass]
}
