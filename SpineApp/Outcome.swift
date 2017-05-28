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
    var code: OutcomeCode
    
    var name: String?
    var description: String?
    
    init(code: OutcomeCode) {
        self.code = code
    }
    
}
