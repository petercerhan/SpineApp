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
    
    func testAttachView_WithInitialState_ShouldAttachView() {
        XCTAssertNotNil(sut.view, "View not attached")
    }
    
    func testLoadData_WithInitialState_ShouldLoadInitialDataToView() {

        sut.loadData()

        XCTAssertEqual(mockView.setElementsCallCount, 1, "Mock view set(elements.. ) not called exactly once")
        XCTAssertEqual(mockView.elements?.count, 3, "Mock view data did not load")
    }
    
    func testResetAll_WithInitialState_ShouldResetData() {

        sut.resetAll()
        
        XCTAssertEqual(mockStateController.resetAllCallCount, 1, "Reset all not called on state controller")
        XCTAssertEqual(mockView.elements?.count, 3, "Mock view elements not updated")
        XCTAssertEqual(mockView.evaluated?.count, 3, "Mock view evaluated not updated")
    }
    
    func test_NomogramSelected() {
        
        sut.nomogramSelected(atIndex: 1)
        
        XCTAssertEqual(mockStateController.nomogramEvaluated[1], true, "Nomogram evaulated not set in state controller")
        XCTAssertEqual(mockCoordinator.nomogramSelectedIndex, 1, "Nomogramevaluated not called at proper index")
    }
    
}


