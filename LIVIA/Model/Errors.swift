//
//  Errors.swift
//  Livia
//
//  Created by MAC on 22/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
// MARK: - Errors
struct Errors: Codable {
    var email: [String]?
    var courseID: [String]?
    var comment: [String]?
    var price: [String]?
    var id_number: [String]?
    var medical_number: [String]?
    var phone : [String]?
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case email
        case comment
        case price
        case id_number
        case medical_number
        case phone
    }
}

struct BaseModel:  Codable {
    let value: Bool?
    let msg: String?
    
    enum CodingKeys: String, CodingKey {
        case value,msg
    }
}
