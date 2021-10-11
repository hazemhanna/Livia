//
//  Cart+CoreDataProperties.swift
//  
//
//  Created by Macbook on 6/30/20.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var cart: Data?

}
