//
//  Double.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/26/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(decimals: Int) -> Double {
        let power = pow(10.0, Double(decimals))
        return (self * power).rounded() / power
    }
    
}
