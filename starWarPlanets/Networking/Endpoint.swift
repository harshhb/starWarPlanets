//
//  Endpoint.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Foundation
import Alamofire

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem] = []
    var method: HTTPMethod = .get

//    var url: URL {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "swapi.info"
//        components.path = "/api" + path
//        components.queryItems = queryItems.isEmpty ? nil : queryItems
//        return components.url!
//    }
}

extension Endpoint {
    static func planets() -> Endpoint {
        return Endpoint(path: "/planets")
    }
}
