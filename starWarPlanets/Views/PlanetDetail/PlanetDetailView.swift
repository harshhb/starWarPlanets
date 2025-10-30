//
//  PlanetDetailView.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import SwiftUI
import SDWebImageSwiftUI
struct PlanetDetailView: View {
    let planet: Planet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                WebImage(url: planet.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    Image("illustration_planet_details")
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(height: 220)
                Group {
                    Text(planet.name ?? "").font(.largeTitle).bold()

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Orbital Period:")
                            Text(planet.orbital_period ?? "N/A")
                        }
                        HStack {
                            Text("Gravity:")
                            Text(planet.gravity ?? "N/A")
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(planet.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockPlanet = Planet(
        name: "Tatooine",
        climate: "arid"
    )
    PlanetDetailView(planet: mockPlanet)
}
