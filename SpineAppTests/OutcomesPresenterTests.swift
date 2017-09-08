//
//  OutcomesPresenterTests.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/31/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class OutcomesPresenterTests: XCTestCase {
    
    var sut: OutcomesPresenter!
    
    var mockView: MockOutcomesView!
    var mockCoordinator: MockOutcomesCoordinator!
    var mockStateController: MockOutcomesStateController!
    
    override func setUp() {
        super.setUp()
        
        mockView = MockOutcomesView()
        mockCoordinator = MockOutcomesCoordinator()
        mockStateController = MockOutcomesStateController()
        
        sut = OutcomesPresenter(delegate: mockCoordinator, outcomesStateController: mockStateController)
        sut.attach(view: mockView)
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockCoordinator = nil
        mockStateController = nil
        
        super.tearDown()
    }
    
    //This is a required set-up step, so is performed in the test fixture
    func testAttachView_WithInitialState_ShouldAttachView() {
        XCTAssertNotNil(sut.view, "View not attached")
    }
    
    func testLoadDataToView_WithInitialState_ShouldLoadInitialDataToView() {

        sut.loadDataToView()

        XCTAssertEqual(mockView.setElementsCallCount, 1, "Mock view set(elements.. ) not called exactly once")
        XCTAssertEqual(mockView.elements?.count, 3, "Mock view data did not load")
    }
    
    func testResetAllData_WithInitialState_ShouldResetData() {

        sut.resetAllData()
        
        XCTAssertEqual(mockStateController.resetAllCallCount, 1, "Reset all not called on state controller")
        XCTAssertEqual(mockView.setElementsCallCount, 1, "Mock view set(elements.. ) not called exactly once")
        XCTAssertEqual(mockView.elements?.count, 3, "Mock view elements not updated")
        XCTAssertEqual(mockView.evaluated?.count, 3, "Mock view evaluated not updated")
    }
    
    func testNomogramSelectedAtIndex1_WithInitialState_ShouldNotifyDelegateNomogram1Selected() {
        
        sut.nomogramSelected(atIndex: 1)

        //separate test?
        XCTAssertEqual(mockStateController.setNomogramEvaluatedCallCount, 1, "setNomogramEvaluated not called exactly 1 time")
        XCTAssertEqual(mockStateController.setNomogramEvaluated_atIndex, 1, "Did not set nomogram evaluated at index 1")
        
        XCTAssertEqual(mockCoordinator.nomogramSelectedCallCount, 1, "Did not call nomogram selected exactly 1 time")
        XCTAssertEqual(mockCoordinator.nomogramSelected_atIndex, 1, "Did not call nomogram selected at index 1")
    }
    
}


