//
//  TestsHelper.swift
//  uikit-conceptTests
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import XCTest

extension XCTest {
    
    func getTransactions() -> [Transaction] {
        [
            Transaction(sku: "sku", amount: "12.34", currency: "EUR"),
            Transaction(sku: "sku", amount: "9.17", currency: "USD"),
            Transaction(sku: "sku", amount: "21.89", currency: "AUD"),
            Transaction(sku: "sku", amount: "47.5", currency: "CAD")
        ]
    }
    
    func getAllConversionRates() async -> [ConversionRate] {
        let conversionRates = try! await MockNetworkService().loadConversionRates()
        return ConversionRateHelper.getAllConversionRates(from: conversionRates)
    }
}
