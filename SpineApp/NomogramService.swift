//
//  NomogramService.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol NomogramGateway {
    func nomogram(forCode code: NomogramCode) -> Nomogram?
}

enum NomogramCode {
    case sea_nonOpFailure
    case sea_paralysis
    case sea_90dayMortality
}

class NomogramService: NomogramGateway {
    
    func nomogram(forCode code: NomogramCode) -> Nomogram? {
        switch code {
        case .sea_nonOpFailure:
            return sea_nonOpFailure()
        case .sea_paralysis:
            return sea_paralysis()
        case .sea_90dayMortality:
            return sea_90dayMortality()
        }
    }
 
    func sea_nonOpFailure() -> Nomogram {
        return Nomogram(outcome: "Failure",
                   description: "Neurologic deterioration, worsened back/radicular pain, persistent symptoms, or progression on serial imaging despite initiation of systemic antibiotic therapy with or without CT-assisted percutaneous drainage.",
                   constant: -1.95,
                   pointscoefficient:  0.21,
                   predictors: [Predictor(name: "Pre-treatment motor deficit", description: NomogramService.description1_1, points: 10, present: false),
                                Predictor(name: "Pathologic/compression fracture", description: NomogramService.description1_2, points: 8.8, present: false),
                                Predictor(name: "Sensory changes", description: NomogramService.description1_3, points: 6.1, present: false),
                                Predictor(name: "Active malignancy", description: NomogramService.description1_4, points: 5.6, present: false),
                                Predictor(name: "Diabetes mellitus", description: NomogramService.description1_5, points: 5.1, present: false),
                                Predictor(name: "Abscess located dorsal to thecal sac", description: NomogramService.description1_6, points: -6.2, present: false)],
                   score: 0)
    }
    
    func sea_paralysis() -> Nomogram {
        return Nomogram(outcome: "Pre-treatment motor deficit",
                    description: "New motor deficit prior to initiation of therapy.",
                    constant: -3.04,
                    pointscoefficient: 0.16,
                    predictors: [Predictor(name: "Sensory changes", description: NomogramService.description2_1, points: 10, present: false),
                                 Predictor(name: "Urinary incontinence/retention", description: NomogramService.description2_2, points: 7.7, present: false),
                                 Predictor(name: "Fecal incontinence/retention", description: NomogramService.description2_3, points: 5.1, present: false),
                                 Predictor(name: "Abcess above conus medullaris", description: NomogramService.description2_4, points: 3.8, present: false),
                                 Predictor(name: "Diabetes mellitus", description: NomogramService.description2_5, points: 2.1, present: false),
                                 Predictor(name: "WBC >12", description: NomogramService.description2_6, points: 1.8, present: false),
                                 Predictor(name: "Abscess located dorsal to thecal sac", description: NomogramService.description2_7, points: -2, present: false),
                                 Predictor(name: "Multiple locations relative to the thecal sac", description: NomogramService.description2_8, points: 3.5, present: false)],
                    score: 0)
    }
    
    func sea_90dayMortality() -> Nomogram {
        return Nomogram(outcome: "90-day mortality",
                     description: "Death within 90 days of discharge or within the hospitalization",
                     constant: -1.66,
                     pointscoefficient: 0.17,
                     predictors: [Predictor(name: "Active malignancy", description: NomogramService.description3_1, points: 10, present: false),
                                  Predictor(name: "Age >65", description: NomogramService.description3_2, points: 8.9, present: false),
                                  Predictor(name: "Hemodialysis", description: NomogramService.description3_3, points: 8.0, present: false),
                                  Predictor(name: "Endocarditis", description: NomogramService.description3_4, points: 5.6, present: false),
                                  Predictor(name: "Diabetes mellitus", description: NomogramService.description3_5, points: 5.0, present: false),
                                  Predictor(name: "Pre-treatment motor deficit", description: NomogramService.description3_6, points: 4.3, present: false),
                                  Predictor(name: "WBC >15", description: NomogramService.description3_7, points: 3.9, present: false),
                                  Predictor(name: "Symptom duration >2 weeks", description: NomogramService.description3_8, points: -7.2, present: false)],
                     score: 0)
    }
 
    
    //MARK: - descriptions
    
    //1 - Failure
    
    static let description1_1 = "Does the patient have a new motor deficit prior to initiation of therapy?\n\nAn existing motor deficit (e.g. from prior stroke) should not be counted as positive."
    
    static let description1_2 = "Does the patient have a pathologic or compression fracture in the involved vertebral levels?"
    
    static let description1_3 = "Does the patient have new paresthesias or frank sensory deficit? An existing sensory deficit or long-standing paresthesias (e.g. from degenerative spine disease, peripheral neuropathy) should not be counted as positive."
    
    static let description1_4 = "Does the patient have a active malignancy at the time of SEA diagnosis?"
    
    static let description1_5 = "Does the patient have comorbid diabetes mellitus at the time of SEA diagnosis?"
    
    static let description1_6 = "The abscess is located purely dorsal to the thecal sac, with no ventral component whatsoever."
    
    //2 - Pre-treatment motor deficit
    
    static let description2_1 = "Does the patient have new paresthesias or frank sensory deficit?\n\nAn existing sensory deficit or long-standing paresthesias (e.g. from degenerative spine disease, peripheral neuropathy) should not be counted as positive."
    
    static let description2_2 = "Does the patient have new urinary incontinence or retention?\n\nIncontinence must be due to loss of sphincter control, as opposed to being unable to make it to the bathroom in time."
    
    static let description2_3 = "Does the patient have new fecal incontinence or retention?\n\nIncontinence must be due to loss of sphincter control, as opposed to being unable to make it to the bathroom in time."
    
    static let description2_4 = "Is the most caudal aspect of the abscess located above L1?"
    
    static let description2_5 = "Does the patient have comorbid diabetes mellitus at the time of SEA diagnosis?"
    
    static let description2_6 = "Is the white blood cell count greater than 12 x 10^3 cells/mm^3 (use superscripts if you can)"
    
    static let description2_7 = "The abscess is located purely dorsal to the thecal sac, with no ventral component whatsoever."
    
    static let description2_8 = "Are components of the abscess located both ventral and dorsal to the thecal sac?"
    
    //3 - 90-day mortality
    
    static let description3_1 = "Does the patient have a active malignancy at the time of SEA diagnosis?"
    
    static let description3_2 = "Is the patient's age greater than 65 years?"
    
    static let description3_3 = "Does the patient undergo regular hemodialysis at the time of SEA diagnosis?"
    
    static let description3_4 = "Does the patient have concurrent infectious endocarditis at the time of SEA diagnosis?"
    
    static let description3_5 = "Does the patient have comorbid diabetes mellitus at the time of SEA diagnosis?"
    
    static let description3_6 = "Does the patient have a new motor deficit prior to initiation of therapy?\n\nAn existing motor deficit (e.g. from prior stroke) should not be counted as positive."
    
    static let description3_7 = "Is the white blood cell count greater than 15 x 10^3 cells/mm^3 (use superscripts if you can)"
    
    static let description3_8 = "Has the patient been experiencing symptoms for greater than 2 weeks?"
    
}




