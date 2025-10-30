//
//  TestHelpers.swift
//  starWarPlanetsTests
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation
import CoreData
import XCTest
@testable import starWarPlanets

final class InMemoryCoreData {
    static func makeContext(testName: String = UUID().uuidString) -> NSManagedObjectContext {
        let model = CoreDataManager.shared.model
        let container = NSPersistentContainer(name: testName, managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("In-memory store failed: \(error)")
            }
        }
        return container.viewContext
    }
}
