//
//  NomogramServiceTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class NomogramServiceTests: XCTestCase {
    
    var sut: NomogramService!
    
    override func setUp() {
        super.setUp()
        
        sut = NomogramService()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testNomogramForCode1_WithInitialState_ShouldReturnNonOpFailureNomogram() {
        let result = sut.nomogram(forCode: .sea_nonOpFailure)
        
        XCTAssertEqual(result?.outcome, "Failure", "Did not retrieve correct nomogram")
    }
    
    func testNomogramForCode2_WithInitialState_ShouldReturnNonOpFailureNomogram() {
        let result = sut.nomogram(forCode: .sea_paralysis)
        
        XCTAssertEqual(result?.outcome, "Pre-treatment motor deficit", "Did not retrieve correct nomogram")
    }
    
    func testNomogramForCode3_WithInitialState_ShouldReturnNonOpFailureNomogram() {
        let result = sut.nomogram(forCode: .sea_90dayMortality)
        
        XCTAssertEqual(result?.outcome, "90-day mortality", "Did not retrieve correct nomogram")
    }
}



