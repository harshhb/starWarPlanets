//
//  PlanetListItemView.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlanetListItemView: View {
    let planet: Planet

    var body: some View {
        HStack(spacing: 10) {
            WebImage(url: planet.imageURL) { image in
                image.resizable()
            } placeholder: {
                Image("ic_planet_placeholder")
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(planet.name ?? "N/A").font(.headline)
                Text("Climate: \(planet.climate ?? "N/A")").font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }}

#Preview {
    let mockPlanet = Planet(
        name: "Tatooine",
        climate: "arid"
    )
    PlanetListItemView(planet: mockPlanet)
}
