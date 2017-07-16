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
        if let nomogram1 = nomogramService.nomogram(code: .sea_nonOpFailure){
            nomograms = [nomogram1]
        } else {
            nomograms = [Nomogram]()
        }
        
        self.nomograms = nomograms
        
        nomogramEvaulated = Array(repeating: false, count: nomograms.count)
        nomogramFailurePct = Array(repeating: 0.0, count: nomograms.count)
    }
    
    func outcomes() -> [String] {
        var outcomes = [String]()
        for nomogram in nomograms {
            outcomes.append(nomogram.outcome)
        }
        
        return outcomes
    }
    
    
}

