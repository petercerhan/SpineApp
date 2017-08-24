//
//  NomogramPresenterTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/23/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class MockNomogramView: NomogramViewProtocol {
    var failurePct: Double = 0
    var outcome: String = ""
    
    var elements = [NomogramElement]()
    
    func set(elements: [NomogramElement]) {
        self.elements = elements
    }
    
    var element: NomogramElement?
    var index = 0
    
    func set(element: NomogramElement, atIndex index: Int) {
        self.element = element
        self.index = index
    }
    
}

class NomogramPresenterTests: XCTestCase {
    
    var presenterUnderTest: NomogramPresenter!
    var mockStateController: MockOutcomesStateController!
    var mockNomogramView: MockNomogramView!
    var mockCoordinator: MockOutcomesCoordinator!
    
    override func setUp() {
        super.setUp()
    
        mockStateController = MockOutcomesStateController()
        mockNomogramView = MockNomogramView()
        mockCoordinator = MockOutcomesCoordinator()
        
        presenterUnderTest = NomogramPresenter(delegate: mockCoordinator, outcomesStateController: mockStateController, nomogramIndex: 1)
        presenterUnderTest.attach(view: mockNomogramView)
    }
    
    override func tearDown() {

        presenterUnderTest = nil
        mockStateController = nil
        mockNomogramView = nil
        mockCoordinator = nil
        
        super.tearDown()
    }
    
    func test_ViewAttached() {
        XCTAssertNotNil(presenterUnderTest.view, "View not attached")
    }
    
    func test_LoadData() {
        presenterUnderTest.loadData()
        
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failure percent not properly set")
        XCTAssertEqual(mockNomogramView.outcome, "Pre-treatment motor deficit", "Outcome not properly set")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not properly added to view")
        //Test that data in the elements is actually correct
    }
    
    func test_UpdatePresent() {
        XCTAssertEqual(mockNomogramView.failurePct, 0, "Not properly initialized")
        
        presenterUnderTest.updatePresent(atIndex: 1)
        
        XCTAssertEqual(mockStateController.updatePredictorIndex, 1, "Did not call proper predictor update")
        XCTAssertEqual(mockStateController.updatePredictorNomogramIndex, 1, "Did not call proper predictor update")
        let testElementName: String? = "Urinary incontinence/retention"
        XCTAssertEqual(mockNomogramView.element?.name, testElementName, "Did not set element properly")
        XCTAssertEqual(mockNomogramView.index, 1, "Did not set element properly")
        
        //Does this not test enough? - we can't tell whether if the failure pct would be properly modified by this function..
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed to update failure percent")
        
    }
    
    func test_ResetNomogram() {
        
        presenterUnderTest.resetNomogram()
        
        XCTAssertNotNil(mockStateController.resetIndex, "Reset not properly called on state controller")
        
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed to update failure percent")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not properly added to view")
    }

    func test_SceneComplete() {
        
        presenterUnderTest.sceneComplete()
        
        XCTAssertEqual(mockCoordinator.nomogramSceneComplete, true, "Scene complete not called")
    }
    
    
}









