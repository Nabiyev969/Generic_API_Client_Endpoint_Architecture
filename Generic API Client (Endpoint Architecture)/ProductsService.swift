//
//  ProductsService.swift
//  Generic API Client (Endpoint Architecture)
//
//  Created by Anar Nabiyev on 29.10.26.
//

import Foundation

final class ProductsService {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchProducts(page: Int) async throws -> [Product] {
        let response: [ProductDTO] = try await apiClient.request(ProductsEndpoint.products(page: page, limit: 20), as: [ProductDTO].self)
        
        return response.map { $0.toDomain() }
    }
}
