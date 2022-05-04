//
//  Transaction.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

struct Transaction: Decodable, Identifiable {
    
    // MARK: - Properties
    
    let id = UUID()
    let sku: String
    let amount: String
    let currency: String
    var description: String {
        "\(amount) \(currency.lowercased())"
    }
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case sku, amount, currency
    }
}
