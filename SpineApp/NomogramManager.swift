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
    
    init(nomogramService: NomogramService) {
        if let nomogram1 = nomogramService.nomogram(named: "NonOperativeFailure"){
            nomograms = [nomogram1]
        } else {
            nomograms = [Nomogram]()
        }
    }
    
    func outcomes() -> [String] {
        var outcomes = [String]()
        for nomogram in nomograms {
            outcomes.append(nomogram.outcome)
        }
        
        return outcomes
    }
    
}
