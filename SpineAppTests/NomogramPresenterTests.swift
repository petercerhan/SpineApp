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
    
    func testAttachView_WithInitialState_ShouldAttachView() {
        XCTAssertNotNil(sut.view, "View not attached")
    }
    
    func testLoadData_WithInitialState_ShouldLoadDataToView() {
        sut.loadData()

        XCTAssertEqual(mockNomogramView.setElements_CallCount, 1, "Set elements not called exactly once")
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failure percent not properly set")
        XCTAssertEqual(mockNomogramView.outcome, "Pre-treatment motor deficit", "Outcome not properly set")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not properly added to view")
        //Test that data in the elements is actually correct
    }
    
    func testUpdatePresentAtIndex1_WithInitialData_ShouldUpdatePresentAtIndex1() {
        sut.loadData()
        
        sut.updatePresent(atIndex: 1)

        XCTAssertEqual(mockOutcomesStateController.updatePredictorCallCount, 1, "Did not call update predictor call count exactly once")
        XCTAssertEqual(mockOutcomesStateController.updatePredictorIndex, 1, "Did not update predictor at index 1")
        XCTAssertEqual(mockOutcomesStateController.updatePredictorNomogramIndex, 1, "Did not update predictor in nomogram 1")
        
        XCTAssertEqual(mockNomogramView.setElement_CallCount, 1, "Did not call set element exactly once")
        XCTAssertEqual(mockNomogramView.element?.name, "Urinary incontinence/retention", "Did not set element properly")
        XCTAssertEqual(mockNomogramView.index, 1, "Did not update element at index 1")
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed to update failure percent")
    }
    
    func testResetNomogramAtIndex1_WithInitialData_ShouldResetNomogramAtIndex1() {
        sut.loadData()
        mockNomogramView.failurePct = 0.20
        mockNomogramView.elements = [NomogramElement]()
        
        sut.resetNomogram()
        
        XCTAssertEqual(mockOutcomesStateController.resetNomogramCallCount, 1, "Did not call reset nomogram exactly once")
        XCTAssertEqual(mockOutcomesStateController.resetIndex, 1, "Did not reset nomogram at index 1")

        //Arrange step calls "set elements" as well
        XCTAssertEqual(mockNomogramView.setElements_CallCount, 2, "Did not set elements exactly once")
        XCTAssertEqual(mockNomogramView.failurePct, 0.12, "Failed percent not updated")
        XCTAssertEqual(mockNomogramView.elements.count, 7, "Table View elements not added to view")
    }

    func testSceneComplete_WithInitialState_ShouldForwardTransitionRequest() {
        sut.sceneComplete()
        
        XCTAssertEqual(mockCoordinator.sceneCompleteCallCount, 1, "Scene complete not called exactly once")
    }
    
    
}









