//
//  OutcomesStateControllerTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class OutcomesStateControllerTests: XCTestCase {
    
    var sut: OutcomesStateController!
    
    override func setUp() {
        super.setUp()
        
        sut = OutcomesStateController(nomogramService: NomogramService())
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testInit_shouldInitializeController() {
        XCTAssertEqual(sut.nomograms.count, 3, "Did not get nomogram data")
        XCTAssertEqual(sut.nomogramEvaluated.count, 3, "Did not initialize nomogram evaluated data")
    }
    
    func testUpdatePredictorAtIndex1_WithInitialState_ShouldUpdatePredictorAtIndex1() {
        _ = sut.updatePredictor(atIndex: 1, inNomogramAtIndex: 1)
        
        XCTAssertEqual(sut.nomograms[1].predictors[1].present, true, "Predictor not updated")
    }
    
    func testSetNomogramEvaluatedIndex1_WithInitialState_ShouldSetNomogramEvaluatedIndex1() {
        sut.setNomogramEvaluated(atIndex: 1)
        
        XCTAssertEqual(sut.nomogramEvaluated[1], true, "Nomogram evaluated not updated")
    }
    
    func testResetNomogramAtIndex1_WithModifiedState_ShouldResetNomogramAtIndex1() {
        _ = sut.updatePredictor(atIndex: 1, inNomogramAtIndex: 1)
        
        sut.resetNomogram(atIndex: 1)
        
        XCTAssertEqual(sut.nomograms[1].predictors[1].present, false, "Nomogram not reset")
    }
    
    func testResetAll_WithModifiedState_ShouldResetAllNomograms() {
        _ = sut.updatePredictor(atIndex: 0, inNomogramAtIndex: 1)
        _ = sut.updatePredictor(atIndex: 1, inNomogramAtIndex: 1)
        _ = sut.updatePredictor(atIndex: 2, inNomogramAtIndex: 1)
        
        sut.resetAll()
        
        XCTAssertEqual(sut.nomograms[0].predictors[1].present, false, "Nomogram not reset")
        XCTAssertEqual(sut.nomograms[1].predictors[1].present, false, "Nomogram not reset")
        XCTAssertEqual(sut.nomograms[2].predictors[1].present, false, "Nomogram not reset")
    }
    
    func testResetAll_WithModifiedState_ShouldResetNomogramEvaluatedData() {
        sut.nomogramEvaluated[1] = true
        sut.nomogramEvaluated[2] = true
        
        sut.resetAll()
        
        XCTAssertEqual(sut.nomogramEvaluated[1], false, "Did not reset nomogram evaluated")
        XCTAssertEqual(sut.nomogramEvaluated[2], false, "Did not reset nomogram evaluated")
    }
    
}

