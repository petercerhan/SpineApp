//
//  NomogramTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class NomogramTests: XCTestCase {
    
    var sut: Nomogram!
    
    override func setUp() {
        super.setUp()
        
        sut = Nomogram(outcome: "Failure",
                       description: nil,
                       constant: -3.2668096,
                       pointscoefficient:  0.21213817,
                       predictors: [Predictor(name: "Motor deficit at presentation", description: "Description 1", points: 10, present: false),
                                    Predictor(name: "Urinary incontinence/retention", description: "Description 2", points: 6.81, present: false),
                                    Predictor(name: "Pathologic/compression fracture", description: "Description 3", points: 6.79, present: false),
                                    Predictor(name: "Ventral abscess component", description: "Description 4", points: 5.53, present: false),
                                    Predictor(name: "Diabetes mellitus", description: "Description 5", points: 5.18, present: false),
                                    Predictor(name: "Sensory changes", description: "Description 6", points: 4.75, present: false),
                                    Predictor(name: "Coagulase-negative staphylocci", description: "Description 7", points: 4.54, present: false)],
                       score: 0)

        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInit_ShouldCreateNomogram() {
        XCTAssertEqual(sut.outcome, "Failure", "Did not set outcome")
        XCTAssertEqual(sut.description, nil, "Description not nil")
        XCTAssertEqual(sut.constant, -3.2668096, "Constant not set")
        XCTAssertEqual(sut.pointscoefficient, 0.21213817, "Points Coefficient not set")
        XCTAssertEqual(sut.predictors.count, 7, "Predictors not set")
    }
    
    func testFailurePct_WithFailureOutcomeData_ShouldCalculateFailureProbability() {
        sut.togglePredictor(atIndex: 0)
        
        XCTAssertEqual(sut.failurePct, 0.24, "Nomogram failure percent incorrect")
    }
    
}
