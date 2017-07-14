//
//  NomogramService.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class NomogramService {
    
    func nomogram(code: NomogramCode) -> Nomogram? {
        switch code {
        case .sea_nonOpFailure:
            return NomogramService.sea_nonOpFailure
        default:
            return nil
        }
    }
    
}


//Nomograms. Could substitute some other method of retrieval or assembly
extension NomogramService {
    
    static let sea_nonOpFailure = Nomogram(outcome: "Failure of non-operative management",
                                              description: "90-day mortality for patients managed with antibiotics.",
                                              predictors: [Predictor(name: "Motor deficit at presentation", description: nil, points: 10, present: false),
                                                           Predictor(name: "Urinary incontinence/retention", description: nil, points: 6.81, present: false),
                                                           Predictor(name: "Pathologic compression/failure", description: nil, points: 6.79, present: false),
                                                           Predictor(name: "Ventral component to abcess", description: nil, points: 5.53, present: false),
                                                           Predictor(name: "Diabetes mellitus", description: nil, points: 5.18, present: false),
                                                           Predictor(name: "Sensory changes", description: nil, points: 4.75, present: false),
                                                           Predictor(name: "Coagulase-negative staphylococci", description: nil, points: 4.54, present: false)],
                                              score: 0)
}

enum NomogramCode {
    case sea_nonOpFailure
    case sea_paralysis
    case sea_90dayMortality
}
