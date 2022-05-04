//
//  MockNetworkService.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

struct MockNetworkService: NetworkProvider {
    
    // MARK: - NetworkProvider
    
    func loadConversionRates() async throws -> [ConversionRate] {
        try loadMockData(for: "rates")
    }
    
    func loadTransactions() async throws -> [Transaction] {
        try loadMockData(for: "transactions")
    }
    
    // MARK: - Support methods
    
    private func loadMockData<T: Decodable>(for resource: String) throws -> T {
        guard let filepath = Bundle.main.path(forResource: resource, ofType: "json") else {
            throw NSError(domain: "Can't get FilePath", code: 99)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
            return try decode(data: data)
        } catch {
            throw error
        }
    }
}
