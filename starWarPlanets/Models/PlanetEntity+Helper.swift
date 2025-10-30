//
//  PlanetEntity+Helper.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation

extension PlanetEntity {
    func toModel() -> Planet {
        Planet(name: name, climate: climate, orbital_period: orbital_period, gravity: gravity)
    }
}
