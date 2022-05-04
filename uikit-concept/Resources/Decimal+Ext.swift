//
//  Decimal+Ext.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import Foundation

extension Decimal {
    
    /// Bankers rounding based on: https://en.wikipedia.org/wiki/Rounding#Round_half_to_even
    var bankersRounding: Decimal {
        var unsafeDecimal = self
        var roundedDecimal = Decimal()
        NSDecimalRound(&roundedDecimal, &unsafeDecimal, 2, .bankers)
        
        return roundedDecimal
    }
}
