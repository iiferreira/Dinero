//
//  AccountSummaryViewControllerTest.swift
//  DineroUnitTests
//
//  Created by Iuri Ferreira on 10/08/23.
//

import Foundation
import XCTest

@testable import Dinero

class AccountSummaryViewControllerTest : XCTestCase {
    var vc : AccountSummaryViewController!
    var mockManager : MockProfileManager!
    
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        mockManager = MockProfileManager()
        vc.profile = mockManager.profile
    }
    
    func testErrorMsgs() throws {
        let serverError = vc.titleAndMessageErrorMsgForTesting(.serverError)
        let decodingError = vc.titleAndMessageErrorMsgForTesting(.decodingError)

        XCTAssertEqual(serverError.0, "Internet error")
        XCTAssertEqual(serverError.1, "Can't Connect to server")
        
        XCTAssertEqual(decodingError.0, "Decoding error")
        XCTAssertEqual(decodingError.1, "Can't decode data")
    }
    

    
}
