//
//  Outcome.swift
//  SpineApp
//
//  Created by Peter Cerhan on 5/27/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

enum OutcomeCode {
    case outcome1, outcome2, outcome3
}

struct Outcome {
    typealias nomogramItem = (predictor: Predictor, points: Int, present: Bool)
    
    var code: OutcomeCode
    var name: String
    var description: String
    var nomogram: [nomogramItem]
    
    var totalPoints = 0
    
    var likelihood: Double {
        get {
            return Double(totalPoints) / 60.0
        }
    }
    
    init(code: OutcomeCode) {
        self.code = code
        name = Outcome.name(forCode: code)
        description = Outcome.name(forCode: code)
        nomogram = Outcome.nomogram(forCode: code)
    }
    
    mutating func set(predictorPresent: Bool, atIndex index: Int) -> Double {
        guard (predictorPresent != nomogram[index].present) else {
            return likelihood
        }
        nomogram[index].present = predictorPresent
        if predictorPresent {
            totalPoints += nomogram[index].points
        } else {
            totalPoints -= nomogram[index].points
        }
        return likelihood
    }
}

//MARK: - Outcome data

extension Outcome {
    
    static func name(forCode code: OutcomeCode) -> String {
        var name = ""
        
        switch code {
        case .outcome1:
            name = "Outcome 1"
        case .outcome2:
            name = "Outcome 2"
        case .outcome3:
            name = "Outcome 3"
        }
    
        return name
    }
    
    static func description(forCode code: OutcomeCode) -> String {
        var description = ""
        
        switch code {
        case .outcome1:
            description = "Description 1"
        case .outcome2:
            description = "Description 2"
        case .outcome3:
            description = "Description 3"
        }
        
        return description
    }
    
    static func nomogram(forCode code: OutcomeCode) -> [nomogramItem] {
        switch code {
        case .outcome1:
            let nomogram: [nomogramItem] = [(predictor: Predictor(code: .predictor1), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor2), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor3), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor4), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor5), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor6), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor7), points: 5, present: false)]
            return nomogram
        case .outcome2:
            let nomogram: [nomogramItem] = [(predictor: Predictor(code: .predictor1), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor2), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor3), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor4), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor5), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor6), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor7), points: 5, present: false)]
            return nomogram
        case .outcome3:
            let nomogram: [nomogramItem] = [(predictor: Predictor(code: .predictor1), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor2), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor3), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor4), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor5), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor6), points: 5, present: false),
                                            (predictor: Predictor(code: .predictor7), points: 5, present: false)]
            return nomogram
        }
    }
    
    
}
