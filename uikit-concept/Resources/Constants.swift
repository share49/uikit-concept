//
//  Constants.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

/// Constants
struct k {
    
    // MARK: - Networking constants
    
    struct Api {
        static let scheme = "https"
        static let host = "quiet-stone-2094.herokuapp.com"
        
        struct Path {
            static let rates = "rates.json"
            static let transactions = "transactions.json"
        }
    }
    
    // MARK: - UI constants
    
    struct VCTitles {
        static let products = "Products"
    }
    
    struct Cells {
        static let transactionCell = "transactionCell"
    }
    
    struct ProductViewModelStrings {
        static let title = "Transactions for %@"
        static let totalAmount = "Total amount: %@€"
    }
}
