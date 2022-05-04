//
//  ProductViewModelTests.swift
//  uikit-conceptTests
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import XCTest
@testable import uikit_concept

@MainActor class ProductViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    func testTitle() async {
        let viewModel = await getProductViewModel()
        XCTAssertEqual(viewModel.title, "Transactions for sku")
    }
    
    func testFormattedTotalAmount() async {
        let viewModel = await getProductViewModel()
        XCTAssertEqual(viewModel.formattedTotalAmount, "Total amount: 86.79€")
    }
    
    // MARK: - Support methods
    
    private func getProductViewModel() async -> ProductViewModel {
        let allConversionRates = await getAllConversionRates()
        let product = Product(sku: "sku", transactions: getTransactions())
        return ProductViewModel(with: product, conversionRates: allConversionRates)
    }
}
