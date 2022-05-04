//
//  Transaction.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

struct Transaction: Decodable {
    
    // MARK: - Properties
    
    let sku: String
    let amount: String
    let currency: String
}
