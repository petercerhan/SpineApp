//
//  NomogramPresenterTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/23/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class NomogramPresenterTests: XCTestCase {
    
    var sut: NomogramPresenter!
    var mockOutcomesStateController: MockOutcomesStateController!
    var mockNomogramView: MockNomogramView!
    var mockCoordinator: MockOutcomesCoordinator!
    
    override func setUp() {
        super.setUp()
    
        mockOutcomesStateController = MockOutcomesStateController()
        mockNomogramView = MockNomogramView()
        mockCoordinator = MockOutcomesCoordinator()
        
        sut = NomogramPresenter(delegate: mockCoordinator, outcomesStateController: mockOutcomesStateController, nomogramIndex: 1)
        sut.attach(view: mockNomogramView)
    }
    
    override func tearDown() {
        sut = nil
        mockOutcomesStateController = nil
        mockNomogramView = nil
        mockCoordinator = nil
        
        super.tearDown()
    }
    
    func test_ViewAttached() {
        XCTAssertNotNil(sut.view, "View not attached")
    }
    
    func test_LoadData() {
        sut.loadData()
        
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failure percent not properly set")
        XCTAssertEqual(mockNomogramView.outcome, "Pre-treatment motor deficit", "Outcome not properly set")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not properly added to view")
        //Test that data in the elements is actually correct
    }
    
    func test_UpdatePresent() {
        XCTAssertEqual(mockNomogramView.failurePct, 0, "Not properly initialized")
        
        sut.updatePresent(atIndex: 1)
        
        XCTAssertEqual(mockOutcomesStateController.updatePredictorIndex, 1, "Did not call proper predictor update")
        XCTAssertEqual(mockOutcomesStateController.updatePredictorNomogramIndex, 1, "Did not call proper predictor update")
        let testElementName: String? = "Urinary incontinence/retention"
        XCTAssertEqual(mockNomogramView.element?.name, testElementName, "Did not set element properly")
        XCTAssertEqual(mockNomogramView.index, 1, "Did not set element properly")
        
        //Does this not test enough? - we can't tell whether if the failure pct would be properly modified by this function..
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed to update failure percent")
        
    }
    
    func test_ResetNomogram() {
        sut.resetNomogram()
        
        XCTAssertNotNil(mockOutcomesStateController.resetIndex, "Reset not properly called on state controller")
        
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed to update failure percent")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not properly added to view")
    }

    func test_SceneComplete() {
        sut.sceneComplete()
        
        XCTAssertEqual(mockCoordinator.nomogramSceneComplete, true, "Scene complete not called")
    }
    
    
}









