//
//  MockAPIClient.swift
//  starWarPlanetsTests
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation
@testable import starWarPlanets

struct MockResponse {
    static let planetsJSON = """
    [
      {
        "name":"Tatooine",
        "orbital_period":"304",
        "climate":"arid",
        "gravity":"1 standard",
      },
      {
        "name":"Alderaan",
        "orbital_period":"364",
        "climate":"temperate",
        "gravity":"1 standard",
      }
    ]
    """.data(using: .utf8)!
}

final class MockAPIClient: APIClientProtocol {
    indirect enum Behavior {
        case success
        case error(Error)
    }

    var behavior: Behavior = .success

    init(behavior: Behavior = .success) {
        self.behavior = behavior
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        switch behavior {
        case .success:
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: MockResponse.planetsJSON)
        case .error(let e):
            throw e
        }
    }
}
