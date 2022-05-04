//
//  NetworkService.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

protocol NetworkProvider {
    func loadConversionRates() async throws -> [ConversionRate]
    func loadTransactions() async throws -> [Transaction]
}

extension NetworkProvider {
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

struct NetworkService: NetworkProvider {
    
    // MARK: - NetworkProvider
    
    func loadConversionRates() async throws -> [ConversionRate] {
        try await getAndDecode(url: Endpoint.rates().url)
    }
    
    func loadTransactions() async throws -> [Transaction] {
        try await getAndDecode(url: Endpoint.transactions().url)
    }
    
    // MARK: - Support methods
    
    private func getAndDecode<T: Decodable>(url: URL, using session: URLSession = .shared) async throws -> T {
        let (data, _) = try await session.data(from: url)
        return try decode(data: data)
    }
}
