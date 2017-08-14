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
}
