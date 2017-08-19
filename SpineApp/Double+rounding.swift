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
    
    func displayAsPercent(significantFigures: Int) -> String {
            return "\((self * 100).significantFigures(significantFigures))%"
    }
    
    func significantFigures(_ digits: Int) -> Double {
        
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.minimumSignificantDigits = digits
        formatter.maximumSignificantDigits = digits
        
        let result = Double(formatter.string(from: NSNumber(floatLiteral: self))!)!
        
        return result
    }
    
}

extension Double {
    static let e = Double(2.718_281_828)
}
