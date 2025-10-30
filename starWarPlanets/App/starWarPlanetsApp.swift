//
//  starWarPlanetsApp.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import SwiftUI
import CoreData

@main
struct starWarPlanetsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PlanetListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
