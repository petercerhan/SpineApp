//
//  NomogramManager.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class NomogramManager {

    //MARK: - Dependencies
    
    let nomogramService: NomogramService
    
    //MARK: - State
    
    var nomograms: [Nomogram]
    var nomogramEvaulated: [Bool]
    var nomogramFailurePct: [Double]
    
    //MARK: - Initialization
    
    init(nomogramService: NomogramService) {
        self.nomogramService = nomogramService
        
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramService.nomogram(code: .sea_nonOpFailure),
            let nomogram2 = nomogramService.nomogram(code: .sea_paralysis),
            let nomogram3 = nomogramService.nomogram(code: .sea_90dayMortality) {
            
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        self.nomograms = nomograms
        
        nomogramEvaulated = Array(repeating: false, count: nomograms.count)
        nomogramFailurePct = Array(repeating: 0.0, count: nomograms.count)
    }
    
    //MARK: - Interface

    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        var predictor = nomograms[nomogramIndex].predictors[predictorIndex]
        predictor.present = !(predictor.present)
        nomograms[nomogramIndex].predictors[predictorIndex] = predictor
        
        let newScore = predictor.present ? nomograms[nomogramIndex].score + predictor.points : nomograms[nomogramIndex].score - predictor.points
        nomograms[nomogramIndex].score = newScore.rounded(decimals: 10)
        nomogramFailurePct[nomogramIndex] = failure(forNomogram: nomograms[nomogramIndex]).rounded(decimals: 10)
        
        return predictor
    }
    
    func resetNomogram(atIndex index: Int) {
        switch index {
        case 0:
            nomograms[index] = nomogramService.nomogram(code: .sea_nonOpFailure)!
        case 1:
            nomograms[index] = nomogramService.nomogram(code: .sea_paralysis)!
        case 2:
            nomograms[index] = nomogramService.nomogram(code: .sea_90dayMortality)!
        default:
            break
        }
        
        nomogramFailurePct[index] = failure(forNomogram: nomograms[index]).rounded(decimals: 10)
    }
    
    func resetAll() {
        var nomograms = [Nomogram]()
        if let nomogram1 = nomogramService.nomogram(code: .sea_nonOpFailure),
            let nomogram2 = nomogramService.nomogram(code: .sea_paralysis),
            let nomogram3 = nomogramService.nomogram(code: .sea_90dayMortality) {
            nomograms = [nomogram1, nomogram2, nomogram3]
        }
        
        nomogramEvaulated = Array(repeating: false, count: nomograms.count)
        nomogramFailurePct = Array(repeating: 0.0, count: nomograms.count)
        self.nomograms = nomograms
    }
    
    //MARK: - Domain Logic
    
    private func failure(forNomogram nomogram: Nomogram) -> Double {

        let c = nomogram.constant
        let p = nomogram.pointscoefficient
        let score = nomogram.score
        let e = Double.e
        
        let failurePct = pow(e, c + p*score) / (1 + pow(e, c + p*score))
        
        //find significant figures
        
        return failurePct
    }
    
}


