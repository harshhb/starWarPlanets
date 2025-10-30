//
//  Planet.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Foundation

struct Planet: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String?
    var climate: String?
    var orbital_period: String?
    var gravity: String?

    var imageURL: URL {
        let seed = name?.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "planet"
        return URL(string: "https://picsum.photos/seed/\(seed)/300/200")!
    }

    private enum CodingKeys: String, CodingKey {
        case name, climate, orbital_period, gravity
    }
}
