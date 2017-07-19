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
        case .sea_paralysis:
            return NomogramService.sea_paralysis
        case .sea_90dayMortality:
            return NomogramService.sea_90dayMortality
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
    
    static let sea_paralysis = Nomogram(outcome: "Pre-treatment motor deficit",
                                        description: "Risk of pre-treatment motor deficit",
                                        predictors: [Predictor(name: "Sensory changes", description: nil, points: 10, present: false),
                                                     Predictor(name: "Urinary incontinence/retention", description: nil, points: 7.33, present: false),
                                                     Predictor(name: "Fecal incontinence/retention", description: nil, points: 6.55, present: false),
                                                     Predictor(name: "Multiple locations relative to thecal sac", description: nil, points: 5.41, present: false),
                                                     Predictor(name: "Abscess above conus medullaris", description: nil, points: 3.77, present: false),
                                                     Predictor(name: "WBC > 12", description: nil, points: 2.17, present: false),
                                                     Predictor(name: "Ventral or circumferential abscess relative to thecal sac", description: nil, points: 1.75, present: false)],
                                        score: 0)
    
    static let sea_90dayMortality = Nomogram(outcome: "90 day mortality",
                                        description: "Risk of 90 day mortality",
                                        predictors: [Predictor(name: "Age greater than 65 years", description: nil, points: 10, present: false),
                                                     Predictor(name: "Active malignancy", description: nil, points: 9.61, present: false),
                                                     Predictor(name: "Hemodialysis", description: nil, points: 9.28, present: false),
                                                     Predictor(name: "Endocarditis", description: nil, points: 6.42, present: false),
                                                     Predictor(name: "Methicillin-resistant S. aureus", description: nil, points: 5.66, present: false),
                                                     Predictor(name: "Diabetes mellitus", description: nil, points: 5.54, present: false),
                                                     Predictor(name: "Pre-treatment motor deficit", description: nil, points: 5.16, present: false),
                                                     Predictor(name: "Immunocompromised status", description: nil, points: 4.17, present: false)],
                                        score: 0)
}

enum NomogramCode {
    case sea_nonOpFailure
    case sea_paralysis
    case sea_90dayMortality
}
