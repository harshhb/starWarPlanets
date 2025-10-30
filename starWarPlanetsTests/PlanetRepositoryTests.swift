//
//  starWarPlanetsTests.swift
//  starWarPlanetsTests
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Testing
@testable import starWarPlanets
import Foundation

@Suite("PlanetRepository Tests")
struct PlanetRepositoryTests {

    @Test("Fetches planets online and caches them")
    func fetchPlanetsOnline() async throws {
        let context = InMemoryCoreData.makeContext(testName: #function)
        let mockAPI = MockAPIClient(behavior: .success)
        let dataStore = PlanetDataStore(context: context)
        let repo = PlanetRepository(apiClient: mockAPI, dataStore: dataStore)

        let planets = try await repo.fetchPlanets()

        #expect(planets.count == 2)
        #expect(planets.first?.name == "Tatooine")
        #expect(dataStore.fetchCachedPlanets().count == 2)
    }

    @Test("Fetches planets from cache when network is unavailable")
    func fetchPlanetsFromCache() async throws {
        let context = InMemoryCoreData.makeContext(testName: #function)
        let mockAPI = MockAPIClient(behavior: .error(URLError(.networkConnectionLost)))
        let dataStore = PlanetDataStore(context: context)
        let cacheData: [Planet] = try JSONDecoder().decode([Planet].self, from: MockResponse.planetsJSON)
        dataStore.save(planets: cacheData)
        let repo = PlanetRepository(apiClient: mockAPI, dataStore: dataStore)

        let planetsFromCache = try await repo.fetchPlanets()

        #expect(planetsFromCache.count == 2)
        #expect(planetsFromCache.first?.name == "Alderaan")
    }
}
