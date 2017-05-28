//
//  Predictor.swift
//  SpineApp
//
//  Created by Peter Cerhan on 5/27/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

enum PredictorCode {
    case predictor1, predictor2, predictor3, predictor4, predictor5, predictor6, predictor7, predictor8, predictor9, predictor10
}

struct Predictor {
    var code: PredictorCode
    var name: String
    var description: String
    
    init(code: PredictorCode) {
        self.code = code
        name = Predictor.name(forCode: code)
        description = Predictor.description(forCode: code)
    }
}

extension Predictor {
    
    static func name(forCode code: PredictorCode) -> String {
        var name = ""
        
        switch code {
        case .predictor1:
            name = "Predictor 1"
        case .predictor2:
            name = "Predictor 2"
        case .predictor3:
            name = "Predictor 3"
        case .predictor4:
            name = "Predictor 4"
        case .predictor5:
            name = "Predictor 5"
        case .predictor6:
            name = "Predictor 6"
        case .predictor7:
            name = "Predictor 7"
        case .predictor8:
            name = "Predictor 8"
        case .predictor9:
            name = "Predictor 9"
        case .predictor10:
            name = "Predictor 10"
        }
        
        return name
    }
    
    static func description(forCode code: PredictorCode) -> String {
        var description = ""
        
        switch code {
        case .predictor1:
            description = "Description 1"
        case .predictor2:
            description = "Description 2"
        case .predictor3:
            description = "Description 3"
        case .predictor4:
            description = "Description 4"
        case .predictor5:
            description = "Description 5"
        case .predictor6:
            description = "Description 6"
        case .predictor7:
            description = "Description 7"
        case .predictor8:
            description = "Description 8"
        case .predictor9:
            description = "Description 9"
        case .predictor10:
            description = "Description 10"
        }
        
        return description
    }
    
}


