//
//  ProductsViewModelTests.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/3/22.
//

import XCTest
@testable import uikit_concept

@MainActor class ProductsViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    func testLoadProducts() async {
        let viewModel = ProductsViewModel(with: MockNetworkService())
        await viewModel.loadProducts()
        
        // Assert that products are loaded and parsed
        
        let products = viewModel.products
        XCTAssertEqual(products.count, 17)

        // Assert products order and transactions
        
        guard let firstProduct = products.first, let lastProduct = products.last else {
            XCTFail("ProductsViewModelTests: Failed to load products.")
            return
        }
        
        XCTAssertEqual(firstProduct.sku, "A0769")
        XCTAssertEqual(firstProduct.transactions.count, 5)
        
        XCTAssertEqual(lastProduct.sku, "Y2800")
        XCTAssertEqual(lastProduct.transactions.count, 2)
    }
}
