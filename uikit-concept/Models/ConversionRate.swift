//
//  ConversionRate.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import Foundation

struct ConversionRate: Decodable {
    
    // MARK: - Properties
    
    let from: String
    let to: String
    let rate: String
}
