//
//  OutcomesStateController.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol OutcomesStateControllerProtocol {
    var nomograms: [Nomogram] { get }
    var nomogramEvaluated: [Bool] { get }
    
    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor
    func setNomogramEvaluated(atIndex index: Int)
    func resetNomogram(atIndex index: Int)
    func resetAll()
}

class OutcomesStateController: OutcomesStateControllerProtocol {

    //MARK: - Dependencies
    
    let nomogramProvider: NomogramProvider
    
    //MARK: - State
    
    var nomograms: [Nomogram]
    var nomogramEvaluated: [Bool]
    
    //MARK: - Initialization
    
    init(nomogramProvider: NomogramProvider) {
        self.nomogramProvider = nomogramProvider
        
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramProvider.nomogram(code: .sea_nonOpFailure),
            let nomogram2 = nomogramProvider.nomogram(code: .sea_paralysis),
            let nomogram3 = nomogramProvider.nomogram(code: .sea_90dayMortality) {
            
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        self.nomograms = nomograms
        
        nomogramEvaluated = Array(repeating: false, count: nomograms.count)
    }
    
    //MARK: - Interface

    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        
        var predictor = nomograms[nomogramIndex].predictors[predictorIndex]
        predictor.present = !(predictor.present)
        nomograms[nomogramIndex].predictors[predictorIndex] = predictor
        
        let newScore = predictor.present ? nomograms[nomogramIndex].score + predictor.points : nomograms[nomogramIndex].score - predictor.points
        nomograms[nomogramIndex].score = newScore.rounded(decimals: 10)
        
        return predictor
    }
    
    func setNomogramEvaluated(atIndex index: Int) {
        nomogramEvaluated[index] = true
    }
    
    func resetNomogram(atIndex index: Int) {
        switch index {
        case 0:
            nomograms[index] = nomogramProvider.nomogram(code: .sea_nonOpFailure)!
        case 1:
            nomograms[index] = nomogramProvider.nomogram(code: .sea_paralysis)!
        case 2:
            nomograms[index] = nomogramProvider.nomogram(code: .sea_90dayMortality)!
        default:
            break
        }
    }
    
    func resetAll() {
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramProvider.nomogram(code: .sea_nonOpFailure),
            let nomogram2 = nomogramProvider.nomogram(code: .sea_paralysis),
            let nomogram3 = nomogramProvider.nomogram(code: .sea_90dayMortality) {
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        nomogramEvaluated = Array(repeating: false, count: nomograms.count)
        self.nomograms = nomograms
    }
}


