//
//  ProductModel.swift
//  Generic API Client (Endpoint Architecture)
//
//  Created by Anar Nabiyev on 29.10.26.
//

import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Decimal
}

struct Product: Identifiable {
    let id: Int
    let name: String
    let price: Decimal
}

extension ProductDTO {
    func toDomain() -> Product {
        Product(id: id, name: title, price: price)
    }
}
