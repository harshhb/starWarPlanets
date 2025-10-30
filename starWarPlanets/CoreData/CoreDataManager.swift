//
//  CoreDataManager.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "starWarPlanets")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext { container.viewContext }

    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }

    var model: NSManagedObjectModel {
        container.managedObjectModel
    }
}
