//
//  NetworkServiceTests.swift
//  uikit-conceptTests
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import XCTest
@testable import uikit_concept

final class NetworkServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    private let networkService = MockNetworkService()
    
    // MARK: - NetworkService

    func testLoadConversionRates() async throws {
        let conversionRates = try await networkService.loadConversionRates()
        
        XCTAssertEqual(conversionRates.count, 6)
        
        let firstConversionRate = conversionRates.first!
        XCTAssertEqual(firstConversionRate.from, "USD")
        XCTAssertEqual(firstConversionRate.to, "AUD")
        XCTAssertEqual(firstConversionRate.rate, "0.61")
    }
    
    func testLoadProducts() async throws {
        let products = try await networkService.loadTransactions()
        
        XCTAssertEqual(products.count, 71)
        
        let firstProduct = products.first!
        XCTAssertEqual(firstProduct.sku, "X9571")
        XCTAssertEqual(firstProduct.amount, "25.6")
        XCTAssertEqual(firstProduct.currency, "EUR")
    }
    
    // MARK: - Endpoints
    
    func testRatesEndpoint() {
        let endpointUrl = Endpoint.rates().url
        let expectedUrl = URL(string: "https://quiet-stone-2094.herokuapp.com/rates.json")
        XCTAssertEqual(endpointUrl, expectedUrl)
    }
    
    func testTransactionsEndpoint() {
        let endpointUrl = Endpoint.transactions().url
        let expectedUrl = URL(string: "https://quiet-stone-2094.herokuapp.com/transactions.json")
        XCTAssertEqual(endpointUrl, expectedUrl)
    }
}
