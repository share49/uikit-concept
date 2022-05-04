//
//  ProductViewModel.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import Foundation

final class ProductViewModel {
    
    // MARK: - Properties

    private let conversionRates: [ConversionRate]
    let product: Product
    var title: String {
        String(format: k.ProductViewModelStrings.title, product.sku)
    }
    var formattedTotalAmount: String {
        String(format: k.ProductViewModelStrings.totalAmount, "\(totalAmount())")
    }

    // MARK: - Initializer
    
    init(with product: Product, conversionRates: [ConversionRate]) {
        self.product = product
        self.conversionRates = conversionRates
    }
    
    // MARK: - Support methods
    
    /// Iterates through product transactions and sums each transaction in euros.
    private func totalAmount() -> Decimal {
        var totalAmount: Decimal = 0

        for transaction in product.transactions {
            do {
                totalAmount += try ConversionRateHelper.getTransactionAmountInEuros(transaction, using: conversionRates)
            } catch {
                NSLog("ProductViewModel: \(error.localizedDescription)")
            }
        }
        
        return totalAmount
    }
}
