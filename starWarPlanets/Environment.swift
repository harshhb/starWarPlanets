//
//  Environment.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-30.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
        }
    }
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    // MARK: - Plist values
    static let baseURL: URL = {
        guard let baseURLString = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLString) else {
            fatalError("Base URL is invalid")
        }
        return url
    }()
}
