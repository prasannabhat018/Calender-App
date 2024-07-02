//
//  NetworkHelpable.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation

protocol APIEndPoint {
    var scheme: HTTPScheme { get }
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var queryParams: [URLQueryItem] { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPScheme: String {
    case https
    case http
}

protocol NetworkHelpable {
    func processRequest<T: Decodable>(
        get api: APIEndPoint,
        completion: ((Result<T, CalenderError>) -> Void)
    )
}

// MARK: Error Handling
enum CalenderError: Error {
    case apiError
}
