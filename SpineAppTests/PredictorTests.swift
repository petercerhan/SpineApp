//
//  PredictorTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class PredictorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    
    func testInit_ShouldCreatePredictor() {
        let sut = Predictor(name: "Motor deficit at presentation", description: "Test Description", points: 10, present: false)
        
        XCTAssertEqual(sut.name, "Motor deficit at presentation", "Name not set")
        XCTAssertEqual(sut.description, "Test Description", "Description not set")
        XCTAssertEqual(sut.points, 10, "Points not set")
        XCTAssertEqual(sut.present, false, "Present not set")
    }
    
}
