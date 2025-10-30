//
//  APIClient.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let session: Session

    init(session: Session = Session(interceptor: RetryPolicy(), eventMonitors: [LoggingEventMonitor()])) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let url = Environment.baseURL.appendingPathComponent(endpoint.path)
        let method = endpoint.method
        let parameters = Dictionary(uniqueKeysWithValues: endpoint.queryItems.map { ($0.name, $0.value ?? "") })

        let task = session.request(url, method: method,
                                   parameters: method == .get ? nil : parameters,
                                  encoding: JSONEncoding.default).serializingDecodable(T.self)
        let response = await task.response
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}


final class LoggingEventMonitor: EventMonitor {
    func requestDidFinish(_ request: Request) {
        print("✅ Request finished: \(request.description)")
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("📦 Response: \(response.debugDescription)")
    }
}

final class RetryPolicy: RequestInterceptor {
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Retry once for network errors
        if request.retryCount < 1, (error as? URLError) != nil {
            completion(.retryWithDelay(1.0))
        } else {
            completion(.doNotRetry)
        }
    }
}
