//
//  Nomogram.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/11/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

struct Nomogram {
    let outcome: String
    let description: String?
    
    //Conversion formula parameters
    let constant: Double
    let pointscoefficient: Double
    
    var predictors: [Predictor]
    var score: Double
    
    var failurePct: Double {
        
        let c = constant
        let p = pointscoefficient
        let e = Double.e
        
        let result = pow(e, c + p*score) / (1 + pow(e, c + p*score))
        
        //find significant figures

        return result
    }
}
