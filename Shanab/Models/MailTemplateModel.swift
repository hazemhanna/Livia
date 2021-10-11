//
//  MailTempelateModel.swift
//  Shanab
//
//  Created by Macbook on 5/27/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
struct MailTemplateModelJSON: Codable {
    var status: Bool?
    var data: mail?
}

// MARK: - Datum

struct mail : Codable {
    
    var mail : [Tempalte]
}

struct Tempalte: Codable {
    
    
   var id: Int?
       var contentNameAr, inputType, contentNameEn: String?
       var valuesAr, valuesEn: String?
       var inputNameAr, inputNameEn: String?
       var createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
         case id
               case contentNameAr = "content_name_ar"
               case inputType = "input_type"
               case contentNameEn = "content_name_en"
               case valuesAr = "values_ar"
               case valuesEn = "values_en"
               case inputNameAr = "input_name_ar"
               case inputNameEn = "input_name_en"
               case createdAt = "created_at"
               case updatedAt = "updated_at"
    }
}
