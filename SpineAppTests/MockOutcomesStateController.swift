//
//  MockOutcomesStateController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/31/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
@testable import SpineApp

class MockOutcomesStateController: OutcomesStateControllerProtocol {
    
    //MARK: - Stubbed data
    
    var nomograms: [Nomogram]
    var nomogramEvaluated: [Bool]
    
    //MARK: - Initialization
    
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

    //MARK: - updatePredictor atIndex
    
    var updatePredictorCallCount = 0
    
    var updatePredictorIndex: Int?
    var updatePredictorNomogramIndex: Int?
    
    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        updatePredictorCallCount += 1
        
        updatePredictorIndex = predictorIndex
        updatePredictorNomogramIndex = nomogramIndex
        
        return nomograms[nomogramIndex].predictors[predictorIndex]
    }
 
    //MARK: - setNomogramEvaluated atIndex
    
    var setNomogramEvaluatedCallCount = 0
    var setNomogramEvaluated_atIndex: Int?
    
    func setNomogramEvaluated(atIndex index: Int) {
        setNomogramEvaluatedCallCount += 1
        setNomogramEvaluated_atIndex = index
    }

    //MARK: - Reset Nomogram atIndex
    
    var resetNomogramCallCount = 0
    
    var resetIndex: Int?
    
    func resetNomogram(atIndex index: Int) {
        resetNomogramCallCount += 1
        resetIndex = index
    }

    //MARK: - ResetAll
    
    var resetAllCallCount = 0
    
    func resetAll() {
        resetAllCallCount += 1
    }
    
}



