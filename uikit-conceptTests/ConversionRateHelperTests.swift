//
//  ConversionRateHelperTests.swift
//  uikit-conceptTests
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import XCTest

final class ConversionRateHelperTests: XCTestCase {
    
    // MARK: - Tests
    
    func testGetAllConversionRates() async {
        let allConversionRates = await getAllConversionRates()
        XCTAssertEqual(allConversionRates.count, 12)
        
        let euroConversionRates = allConversionRates.filter { $0.to == "EUR" }
        XCTAssertEqual(euroConversionRates.first(where: { $0.from == "USD" })?.rate, "0.64")
        XCTAssertEqual(euroConversionRates.first(where: { $0.from == "AUD" })?.rate, "1.05")
        XCTAssertEqual(euroConversionRates.first(where: { $0.from == "CAD" })?.rate, "0.96")
    }
    
    func testConvertTransactionAmountToEur() async {
        let transactions = getTransactions()
        let allConversionRates = await getAllConversionRates()
        
        var transaction = transactions[0]
        var transactionAmount = try? ConversionRateHelper.getTransactionAmountInEuros(transaction, using: allConversionRates)
        XCTAssertEqual(transactionAmount, transaction.amount.toDecimal())
        
        transaction = transactions[1]
        transactionAmount = try? ConversionRateHelper.getTransactionAmountInEuros(transaction, using: allConversionRates)
        XCTAssertEqual(transactionAmount, 5.87)
        
        transaction = transactions[2]
        transactionAmount = try? ConversionRateHelper.getTransactionAmountInEuros(transaction, using: allConversionRates)
        XCTAssertEqual(transactionAmount, 22.98)
        
        transaction = transactions[3]
        transactionAmount = try? ConversionRateHelper.getTransactionAmountInEuros(transaction, using: allConversionRates)
        XCTAssertEqual(transactionAmount, 45.6)
    }
}
