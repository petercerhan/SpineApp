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
        let scale = pow(10.0, Double(decimals))
        return (self * scale).rounded() / scale
    }
    
    func displayAsPercent(decimals: Int) -> String {
        let rounded = (self * 100).rounded(decimals: decimals)
        return "\(rounded)%"
    }
    
}
