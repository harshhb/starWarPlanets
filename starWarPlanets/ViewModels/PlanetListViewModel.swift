//
//  PlanetListViewModel.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Foundation
import Combine

@MainActor
final class PlanetListViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: PlanetRepositoryProtocol

    init(repository: PlanetRepositoryProtocol) {
        self.repository = repository
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetched = try await repository.fetchPlanets()
            self.planets = fetched.sorted { $0.name ?? "" < $1.name ?? "" }
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func filtered(_ query: String) -> [Planet] {
        guard !query.isEmpty else { return planets }
        return planets.filter { $0.name?.localizedCaseInsensitiveContains(query) ?? false }
    }
}
