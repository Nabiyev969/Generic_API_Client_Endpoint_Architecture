//
//  APIClient.swift
//  Generic API Client (Endpoint Architecture)
//
//  Created by Anar Nabiyev on 29.10.26.
//

import Foundation

final class APIClient {
    
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(baseURL: URL, session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable> (_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        let request = try endpoint.makeRequest(baseURL: baseURL)
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw NetworkError.transport(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.unacceptableStatusCode(httpResponse.statusCode, data)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
