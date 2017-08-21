//
//  NomogramProvider.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

class NomogramProvider {
    
    func nomogram(code: NomogramCode) -> Nomogram? {
        switch code {
        case .sea_nonOpFailure:
            return sea_nonOpFailure()
        case .sea_paralysis:
            return sea_paralysis()
        case .sea_90dayMortality:
            return sea_90dayMortality()
        default:
            return nil
        }
    }
    
}

extension NomogramProvider {
    
    func sea_nonOpFailure() -> Nomogram {
        return Nomogram(outcome: "Failure",
                   description: nil,
                   constant: -3.2668096,
                   pointscoefficient:  0.21213817,
                   predictors: [Predictor(name: "Motor deficit at presentation", description: NomogramProvider.description1_1, points: 10, present: false),
                                Predictor(name: "Urinary incontinence/retention", description: NomogramProvider.description1_2, points: 6.81, present: false),
                                Predictor(name: "Pathologic/compression fracture", description: NomogramProvider.description1_3, points: 6.79, present: false),
                                Predictor(name: "Ventral abscess component", description: NomogramProvider.description1_4, points: 5.53, present: false),
                                Predictor(name: "Diabetes mellitus", description: NomogramProvider.description1_5, points: 5.18, present: false),
                                Predictor(name: "Sensory changes", description: NomogramProvider.description1_6, points: 4.75, present: false),
                                Predictor(name: "Coagulase-negative staphylocci", description: NomogramProvider.description1_7, points: 4.54, present: false)],
                   score: 0)
    }
    
    func sea_paralysis() -> Nomogram {
        return Nomogram(outcome: "Pre-treatment motor deficit",
                    description: nil,
                    constant: -2.002155,
                    pointscoefficient: 0.1679213,
                    predictors: [Predictor(name: "Sensory changes", description: NomogramProvider.description2_1, points: 10, present: false),
                                 Predictor(name: "Urinary incontinence/retention", description: NomogramProvider.description2_2, points: 7.33, present: false),
                                 Predictor(name: "Fecal incontinence/retention", description: NomogramProvider.description2_3, points: 6.55, present: false),
                                 Predictor(name: "Multiple locations relative to the thecal sac", description: NomogramProvider.description2_4, points: 5.41, present: false),
                                 Predictor(name: "Abscess above the conus medullaris", description: NomogramProvider.description2_5, points: 3.77, present: false),
                                 Predictor(name: "WBC >12", description: NomogramProvider.description2_6, points: 2.17, present: false),
                                 Predictor(name: "Ventral or circumferential abscess relative to thecal sac", description: NomogramProvider.description2_7, points: 1.75, present: false)],
                    score: 0)
    }
    
    func sea_90dayMortality() -> Nomogram {
        return Nomogram(outcome: "90-day mortality",
                     description: nil,
                     constant: -3.6202408,
                     pointscoefficient: 0.13411772,
                     predictors: [Predictor(name: "Age >65", description: NomogramProvider.description3_1, points: 10, present: false),
                                  Predictor(name: "Active malignancy", description: NomogramProvider.description3_2, points: 9.61, present: false),
                                  Predictor(name: "Hemodialysis", description: NomogramProvider.description3_3, points: 9.28, present: false),
                                  Predictor(name: "Endocarditis", description: NomogramProvider.description3_4, points: 6.42, present: false),
                                  Predictor(name: "Methicillin-resistant S. aureus", description: NomogramProvider.description3_5, points: 5.66, present: false),
                                  Predictor(name: "Diabetes mellitus", description: NomogramProvider.description3_6, points: 5.54, present: false),
                                  Predictor(name: "Motor deficit at presentation", description: NomogramProvider.description3_7, points: 5.16, present: false),
                                  Predictor(name: "Immunocompromised status", description: NomogramProvider.description3_8, points: 4.17, present: false)],
                     score: 0)
    }
    
}

//MARK: - descriptions

extension NomogramProvider {
    
    //1 - Failure
    
    static let description1_1 = "Does the patient have a new ASIA A, B, C, or D grade below the level of injury?\n\nAn existing motor deficit (e.g. from stroke, peripheral neuropathy) should not be counted as positive."
    
    static let description1_2 = "Does the patient have new urinary incontinence or retention?\n\nIncontinence must be due to loss of sphincter control, as opposed to being unable to make it to the bathroom in time."
    
    static let description1_3 = "Does the patient have a pathologic or compression fracture in the involved vertebral levels?"
    
    static let description1_4 = "Is any part of the abscess located ventral to the thecal sac?"
    
    static let description1_5 = "Does the patient have comorbid diabetes mellitus at the time of SEA diagnosis?"
    
    static let description1_6 = "Does the patient have new paresthesias or frank sensory deficit?\n\nAn existing sensory deficit or long-standing paresthesias (e.g. from degenerative spine disease, peripheral neuropathy) should not be counted as positive."
    
    static let description1_7 = "Do blood and/or wound cultures grow coagulase-negative staphylococci (CoNS).\n\nSince CoNS are frequent contaminants, ensure that this is a true positive culture (i.e. multiple positive bottles)"
    
    //2 - Pre-treatment motor deficit
    
    static let description2_1 = "Does the patient have new paresthesias or frank sensory deficit?\n\nAn existing sensory deficit or long-standing paresthesias (e.g. from degenerative spine disease, peripheral neuropathy) should not be counted as positive."
    
    static let description2_2 = "Does the patient have new urinary incontinence or retention?\n\nIncontinence must be due to loss of sphincter control, as opposed to being unable to make it to the bathroom in time."
    
    static let description2_3 = "Does the patient have new fecal incontinence or retention?\n\nIncontinence must be due to loss of sphincter control, as opposed to being unable to make it to the bathroom in time."
    
    static let description2_4 = "Are components of the abscess located both ventral and dorsal to the thecal sac?"
    
    static let description2_5 = "Is the most caudal aspect of the abscess located above L1?"
    
    static let description2_6 = "Is the white blood cell count greater than 12 x 10^3 cells/mm^3 (use superscripts if you can)"
    
    static let description2_7 = "Is the abscess purely ventral to the thecal sac or circumferentially surround the thecal sac?"
    
    static let description2_8 = "Is the abscess located purely dorsal to the thecal sac (i.e. there is no ventral component to the abscess)"
    
    //3 - 90-day mortality
    
    static let description3_1 = "Is the patient's age greater than 65 years?"
    
    static let description3_2 = "Does the patient have a active malignancy at the time of SEA diagnosis?"
    
    static let description3_3 = "Does the patient undergo regular hemodialysis at the time of SEA diagnosis?"
    
    static let description3_4 = "Does the patient have concurrent infectious endocarditis at the time of SEA diagnosis?"
    
    static let description3_5 = "Do blood and/or wound cultures grow MRSA?"
    
    static let description3_6 = "Does the patient have comorbid diabetes mellitus at the time of SEA diagnosis?"
    
    static let description3_7 = "Does the patient have a new ASIA A, B, C, or D grade below the level of injury?\n\nAn existing motor deficit (e.g. from stroke, peripheral neuropathy) should not be counted as positive."
    
    static let description3_8 = "Does the patient have an immunosuppressive condition or taking immunosuppressive medications?"
    
    
}

enum NomogramCode {
    case sea_nonOpFailure
    case sea_paralysis
    case sea_90dayMortality
}



