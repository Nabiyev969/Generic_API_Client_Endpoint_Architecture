//
//  ProductsEndpoint.swift
//  Generic API Client (Endpoint Architecture)
//
//  Created by Anar Nabiyev on 29.10.26.
//

import Foundation

enum ProductsEndpoint: Endpoint {
    case products(page: Int, limit: Int)
    case product(id: Int)
    
    var path: String {
        switch self {
        case .products:
            return "/v1/products"
        case .product(let id):
            return "/v1/products/\(id)"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .products(page, limit):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        case .product:
            return []
        }
    }
}
