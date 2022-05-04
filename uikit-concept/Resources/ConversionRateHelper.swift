//
//  ConversionRateHelper.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import Foundation

enum ConversionRateErrors: Error {
    case noRateAvailable
    case cantConvertToDecimal
}

struct ConversionRateHelper {
    
    // MARK: - Internal methods
    
    static func getAllConversionRates(from conversionRates: [ConversionRate]) -> [ConversionRate] {
        expandConversionRates(expandConversionRates(conversionRates))
    }
    
    /// Get the transaction amount in euros using bankers rounding.
    static func getTransactionAmountInEuros(_ transaction: Transaction, using conversionRates: [ConversionRate]) throws -> Decimal {
        do {
            let conversionRate = try getConversionRate(for: transaction.currency, from: conversionRates)
            
            guard let decimalAmount = transaction.amount.toDecimal() else {
                throw ConversionRateErrors.cantConvertToDecimal
            }
            
            let convertedAmount = decimalAmount * conversionRate
            return convertedAmount.bankersRounding
            
        } catch {
            NSLog(error.localizedDescription)
        }
        
        throw ConversionRateErrors.noRateAvailable
    }
    
    // MARK: - Private methods
    
    /// Iterates through all the available conversion rates and creates new ones that are missing.
    private static func expandConversionRates(_ conversionRates: [ConversionRate]) -> [ConversionRate] {
        var expandedConversionRates = conversionRates
        
        for conversionRate in conversionRates {
            var destinationRates = conversionRates.filter({ $0.from == conversionRate.to })
            destinationRates.removeAll { $0.from == conversionRate.to && $0.to == conversionRate.from }
            
            for destinationRate in destinationRates {
                let newRate = Decimal(string: conversionRate.rate)! * Decimal(string: destinationRate.rate)!
                let newConversionRate = ConversionRate(from: conversionRate.from, to: destinationRate.to, rate: "\(newRate.bankersRounding)")
                
                if !expandedConversionRates.contains(where: { $0.from == newConversionRate.from && $0.to == newConversionRate.to }) {
                    expandedConversionRates.append(newConversionRate)
                }
            }
        }
        
        return expandedConversionRates
    }
    
    /// Gets a conversion rate for a given currency from all the conversion rates available.
    /// - Parameters:
    ///   - currency: Initial currency
    ///   - conversionRates: All the available conversion rates.
    /// - Returns: The rate to convert the initial currency to euros.
    private static func getConversionRate(for currency: String, from conversionRates: [ConversionRate]) throws -> Decimal {
        let euroCurrency = "EUR"
        
        guard currency != euroCurrency else {
            return 1
        }
        
        if let conversionRate = conversionRates.first(where: { $0.from == currency && $0.to == euroCurrency }),
           let rate = conversionRate.rate.toDecimal() {
            
            return rate
        }
        
        throw ConversionRateErrors.noRateAvailable
    }
}
