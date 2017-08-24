//
//  SpineAppTests.swift
//  SpineAppTests
//
//  Created by Peter Cerhan on 5/26/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import XCTest
@testable import SpineApp

class MockOutcomesStateController: OutcomesStateControllerProtocol {
    var nomograms: [Nomogram]
    var nomogramEvaluated: [Bool]
    
    var resetIndex: Int?
    
    var resetAllCalled = false
    
    init() {
        let nomogramProvider = NomogramProvider()
        
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramProvider.nomogram(code: .sea_nonOpFailure),
            let nomogram2 = nomogramProvider.nomogram(code: .sea_paralysis),
            let nomogram3 = nomogramProvider.nomogram(code: .sea_90dayMortality) {
            
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        self.nomograms = nomograms
        nomogramEvaluated = Array(repeating: false, count: nomograms.count)
    }
    
    var updatePredictorIndex = -1
    var updatePredictorNomogramIndex = -1
    
    //Will need update for testing NomogramPresenter
    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        updatePredictorIndex = predictorIndex
        updatePredictorNomogramIndex = nomogramIndex
        
        return nomograms[nomogramIndex].predictors[predictorIndex]
    }
    
    func setNomogramEvaluated(atIndex index: Int) {
        nomogramEvaluated[index] = true
    }
    
    func resetNomogram(atIndex index: Int) {
        resetIndex = index
    }
    
    func resetAll() {
        resetAllCalled = true
    }
    
}

class MockOutcomesCoordinator: OutcomesPresenterDelegate, NomogramPresenterDelegate {
    
    var sceneCompleteCalled = false
    var nomogramSelectedIndex: Int?
    var nomogramSceneComplete = false
    
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter) {
        sceneCompleteCalled = true
    }
    
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int) {
        nomogramSelectedIndex = index
    }
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        nomogramSceneComplete = true
    }
    
}


class SpineAppTests: XCTestCase {
    
    class MockOutcomesView: OutcomesViewProtocol {
        
        var elements = [OutcomesElement]()
        var evaluated = [Bool]()
        
        func set(elements: [OutcomesElement], evaluated: [Bool]) {
            self.elements = elements
            self.evaluated = evaluated
        }

        var elementSet: OutcomesElement?
        var evaluatedSet: Bool?
        var indexSet: Int?
        
        func set(element: OutcomesElement, evaluated: Bool, atIndex index: Int) -> Bool {
            elementSet = element
            evaluatedSet = evaluated
            indexSet = index
            
            return true
        }
        
    }
    

    
    
    var presenterUnderTest: OutcomesPresenter!
    var mockView: MockOutcomesView!
    var mockCoordinator: MockOutcomesCoordinator!
    var mockStateController: MockOutcomesStateController!
    
    override func setUp() {
        super.setUp()
        
        mockView = MockOutcomesView()
        mockCoordinator = MockOutcomesCoordinator()
        mockStateController = MockOutcomesStateController()
        
        presenterUnderTest = OutcomesPresenter(delegate: mockCoordinator, outcomesStateController: mockStateController)
        presenterUnderTest.attach(view: mockView)
    }
    
    override func tearDown() {
        presenterUnderTest = nil
        mockView = nil
        mockCoordinator = nil
        mockStateController = nil
        
        super.tearDown()
    }
    
    
    func test_ViewAttached() {
        XCTAssertNotNil(presenterUnderTest.view, "View not attached")
    }
    
    func test_DataLoaded() {
        XCTAssertEqual(mockView.elements.count, 0, "Mock View Data not properly initialized")
        
        presenterUnderTest.loadData()
        
        XCTAssertEqual(mockView.elements.count, 3, "Mock view data did not load")
    }

    func test_ResetAll() {
        XCTAssertEqual(mockStateController.resetAllCalled, false, "Mock state controller not reset all not properly initialized")
        XCTAssertEqual(mockView.elements.count, 0, "Mock View Data not properly initialized")
        XCTAssertEqual(mockView.evaluated.count, 0, "Mock view data not properly initialized")
        
        presenterUnderTest.resetAll()
        
        XCTAssertEqual(mockStateController.resetAllCalled, true, "Reset all not called on state controller")
        XCTAssertEqual(mockView.elements.count, 3, "Mock view elements not updated")
        XCTAssertEqual(mockView.evaluated.count, 3, "Mock view evaluated not updated")
    }

    func test_NomogramSelected() {
        XCTAssertEqual(mockStateController.nomogramEvaluated[1], false, "Mock state controller not properly initialized")
        XCTAssertNil(mockCoordinator.nomogramSelectedIndex, "Mock coordinator not properly initialized")
        
        presenterUnderTest.nomogramSelected(atIndex: 1)
        
        XCTAssertEqual(mockStateController.nomogramEvaluated[1], true, "Nomogram evaulated not set in state controller")
        XCTAssertEqual(mockCoordinator.nomogramSelectedIndex, 1, "Nomogramevaluated not called at proper index")
    }
    
}


























