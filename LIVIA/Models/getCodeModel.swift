//
//  getCodeModel.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation

struct GetCodeModel: Codable {
    var status: Bool?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var code: Int?
}
