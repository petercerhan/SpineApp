//
//  NomogramManager.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class NomogramManager {
    
    var nomograms: [Nomogram]
    var nomogramEvaulated: [Bool]
    var nomogramFailurePct: [Double]
    
    init(nomogramService: NomogramService) {
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

    func updatePredictor(atIndex predictorIndex: Int, inNomogramAtIndex nomogramIndex: Int) -> Predictor {
        var predictor = nomograms[nomogramIndex].predictors[predictorIndex]
        predictor.present = !(predictor.present)
        nomograms[nomogramIndex].predictors[predictorIndex] = predictor
        
        nomograms[nomogramIndex].score = predictor.present ? nomograms[nomogramIndex].score + predictor.points : nomograms[nomogramIndex].score - predictor.points
        nomogramFailurePct[nomogramIndex] = failure(forNomogram: nomograms[nomogramIndex])
        
        return predictor
    }
    
    func failure(forNomogram nomogram: Nomogram) -> Double {
        let score = nomogram.score
        return score / 100
    }
    
//    func outcomes() -> [String] {
//        var outcomes = [String]()
//        for nomogram in nomograms {
//            outcomes.append(nomogram.outcome)
//        }
//        
//        return outcomes
//    }
    
}

