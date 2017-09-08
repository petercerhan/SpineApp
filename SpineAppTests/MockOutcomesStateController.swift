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
    var nomograms: [Nomogram]
    var nomogramEvaluated: [Bool]
    
    var resetIndex: Int?
    
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
    
    var setNomogramEvaluatedCallCount = 0
    var setNomogramEvaluated_atIndex: Int?
    
    func setNomogramEvaluated(atIndex index: Int) {
        setNomogramEvaluatedCallCount += 1
        setNomogramEvaluated_atIndex = index
    }
    
    func resetNomogram(atIndex index: Int) {
        resetIndex = index
    }
    
    
    var resetAllCallCount = 0
    
    func resetAll() {
        resetAllCallCount += 1
    }
    
}



