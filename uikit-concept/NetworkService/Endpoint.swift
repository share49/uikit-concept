//
//  Endpoint.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

struct Endpoint {
    
    // MARK: - Properties
    
    var path: String
    var queryItems = [URLQueryItem]()
    var url: URL {
        var components = URLComponents()
        components.scheme = k.Api.scheme
        components.host = k.Api.host
        components.path = "/" + path

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
    
    // MARK: - Endpoints

    static func rates() -> Self {
        Endpoint(path: k.Api.Path.rates)
    }
    
    static func transactions() -> Self {
        Endpoint(path: k.Api.Path.transactions)
    }
}
