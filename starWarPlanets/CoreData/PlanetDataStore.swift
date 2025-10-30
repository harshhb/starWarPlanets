//
//  PlanetDataStore.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation
import CoreData

protocol PlanetDataStoreProtocol {
    func fetchCachedPlanets() -> [Planet]
    func save(planets: [Planet])
    func clearCache()
}

final class PlanetDataStore: PlanetDataStoreProtocol {
//    private let context = CoreDataManager.shared.context

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }


    func fetchCachedPlanets() -> [Planet] {
        let request: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let entities = try context.fetch(request)
            return entities.map { $0.toModel() }
        } catch {
            print("❌ Failed to fetch cached planets: \(error)")
            return []
        }
    }

    func save(planets: [Planet]) {
        clearCache()
        planets.forEach { planet in
            let entity = PlanetEntity(context: context)
            entity.name = planet.name
            entity.climate = planet.climate
            entity.gravity = planet.gravity
            entity.orbital_period = planet.orbital_period
        }
        CoreDataManager.shared.saveContext()
    }

    func clearCache() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PlanetEntity")
        do {
            let entities = try context.fetch(fetch) as? [PlanetEntity] ?? []
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        } catch {
            print("❌ Manual delete failed: \(error)")
        }
    }
}
