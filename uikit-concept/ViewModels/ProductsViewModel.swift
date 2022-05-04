//
//  ProductsViewModel.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/3/22.
//

import Foundation

@MainActor class ProductsViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private(set) var conversionRates = [ConversionRate]()
    @Published private(set) var products = [Product]()
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Load products
    
    func loadProducts() async {
        do {
            let transactions = try await networkService.loadTransactions()
            products = parseTransactionsIntoProducts(transactions)
        } catch {
            NSLog("ProductsViewModel: Error loading transactions. \(error)")
        }
    }
    
    func loadConversionRates() async {
        do {
            let downloadedRates = try await networkService.loadConversionRates()
            conversionRates = ConversionRateHelper.getAllConversionRates(from: downloadedRates)
        } catch {
            NSLog("ProductsViewModel: Error getting conversion rates. \(error)")
        }
    }
    
    // MARK: - Support methods
    
    /// Gets a [Transaction] and transforms it to a [Product] for each unique sku.
    private func parseTransactionsIntoProducts(_ transactions: [Transaction]) -> [Product] {
        var uniqueProducts = [String: [Transaction]]()

        for transaction in transactions {
            if uniqueProducts[transaction.sku] == nil {
                uniqueProducts[transaction.sku] = [transaction]
            } else {
                uniqueProducts[transaction.sku]?.append(transaction)
            }
        }
        
        return uniqueProducts.map { key, value in Product(sku: key, transactions: value) }.sorted { $0.sku < $1.sku }
    }
}
