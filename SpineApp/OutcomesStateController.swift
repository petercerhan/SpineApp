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
    
    let nomogramService: NomogramGateway
    
    //MARK: - State
    
    var nomograms: [Nomogram]
    var nomogramEvaluated: [Bool]
    
    //MARK: - Initialization
    
    init(nomogramService: NomogramGateway) {
        self.nomogramService = nomogramService
        
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramService.nomogram(forCode: .sea_nonOpFailure),
            let nomogram2 = nomogramService.nomogram(forCode: .sea_paralysis),
            let nomogram3 = nomogramService.nomogram(forCode: .sea_90dayMortality) {
            
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        self.nomograms = nomograms
        
        nomogramEvaluated = Array(repeating: false, count: nomograms.count)
    }
    
    //MARK: - Interface

    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        nomograms[nomogramIndex].togglePredictor(atIndex: predictorIndex)
        
        return nomograms[nomogramIndex].predictors[predictorIndex]
    }
    
    func setNomogramEvaluated(atIndex index: Int) {
        nomogramEvaluated[index] = true
    }
    
    func resetNomogram(atIndex index: Int) {
        switch index {
        case 0:
            nomograms[index] = nomogramService.nomogram(forCode: .sea_nonOpFailure)!
        case 1:
            nomograms[index] = nomogramService.nomogram(forCode: .sea_paralysis)!
        case 2:
            nomograms[index] = nomogramService.nomogram(forCode: .sea_90dayMortality)!
        default:
            break
        }
    }
    
    func resetAll() {
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramService.nomogram(forCode: .sea_nonOpFailure),
            let nomogram2 = nomogramService.nomogram(forCode: .sea_paralysis),
            let nomogram3 = nomogramService.nomogram(forCode: .sea_90dayMortality) {
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        nomogramEvaluated = Array(repeating: false, count: nomograms.count)
        self.nomograms = nomograms
    }
}


