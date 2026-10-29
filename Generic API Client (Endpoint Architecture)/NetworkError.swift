//
//  NetworkError.swift
//  Generic API Client (Endpoint Architecture)
//
//  Created by Anar Nabiyev on 29.10.26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case unacceptableStatusCode(Int, Data)
    case decoding(Error)
    case transport(Error)
}
