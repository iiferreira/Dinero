//
//  CurrencyFormatterTest.swift
//  DineroUnitTests
//
//  Created by Iuri Ferreira on 25/07/23.
//

import Foundation
import XCTest

@testable import Dinero

class Test: XCTestCase {
    
    var formatter: CurrencyFormatter!
    
    override func setUp()  {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
        
    }
    
    func testDollarsFormatted() throws {
        let newResult = formatter.dollarsFormatted(1000)
        XCTAssertEqual(newResult, "1,000.00 US dollars")
    }
}
