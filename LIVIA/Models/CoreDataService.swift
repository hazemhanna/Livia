//
//  CoreDataService.swift
//  Shanab
//
//  Created by Macbook on 6/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    
    private init() {
        
    }
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Shanab")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("CoreData Successfully Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
