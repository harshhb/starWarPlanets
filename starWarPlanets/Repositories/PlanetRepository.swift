//
//  PlanetRepository.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Foundation

protocol PlanetRepositoryProtocol {
    func fetchPlanets() async throws -> [Planet]
}

final class PlanetRepository: PlanetRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let dataStore: PlanetDataStoreProtocol

    init(apiClient: APIClientProtocol = APIClient(), dataStore: PlanetDataStoreProtocol = PlanetDataStore()) {
        self.apiClient = apiClient
        self.dataStore = dataStore
    }

    func fetchPlanets() async throws -> [Planet] {
        do {
            print("fetching data from network....")
            let planets: [Planet] = try await apiClient.request(.planets())
            dataStore.save(planets: planets)
            return planets
        } catch {
            print("network not available, fetching cached data...")
            let cached = dataStore.fetchCachedPlanets()
            if cached.isEmpty {
                throw URLError(.notConnectedToInternet)
            }
            return cached
        }
    }
}
