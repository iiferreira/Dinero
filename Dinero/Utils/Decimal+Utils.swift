//
//  DecimalUtils.swift
//  Dinero
//
//  Created by Iuri Ferreira on 20/07/23.
//

import Foundation

extension Decimal {
    var doubleValue : Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
