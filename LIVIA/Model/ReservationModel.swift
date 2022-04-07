//
//  ReservationModel.swift
//  Livia
//
//  Created by MAC on 07/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation

struct ReservationModelJSON: Codable {
    let value: Bool?
    let data: ReservationModel?
    let msg: String?
}

struct ReservationModel: Codable {
    
    let tableReservations: TableReservations?
    
    enum CodingKeys: String, CodingKey {
        case tableReservations = "table_reservations"
    }
}

struct TableReservations: Codable {
    let tableReservations: [Cart]?
    let paginate: Paginate?

    enum CodingKeys: String, CodingKey {
        case tableReservations = "table_reservations"
        case paginate
    }
}
