//
//  String+Ext.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

import Foundation

extension String {
    
    func toDecimal() -> Decimal? {
        Decimal(string: self)
    }
}
