//
//  AccountTest.swift
//  DineroUnitTests
//
//  Created by Iuri Ferreira on 08/08/23.
//

import Foundation
import XCTest

@testable import Dinero

class AccountTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testAccount() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """
        
        guard let data = json.data(using: .utf8) else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let result = try! decoder.decode([Account].self, from: data)
        
        guard let jsonResult = result.first else { return }
        
        XCTAssertEqual(jsonResult.name, "Basic Savings")
        XCTAssertEqual(jsonResult.type, .Banking)
    }
}
