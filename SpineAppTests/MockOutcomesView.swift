//
//  MockNomogramView.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/31/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
@testable import SpineApp

class MockOutcomesView: OutcomesViewProtocol {
    
    var elements = [OutcomesElement]()
    var evaluated = [Bool]()
    
    func set(elements: [OutcomesElement], evaluated: [Bool]) {
        self.elements = elements
        self.evaluated = evaluated
    }
    
    var elementSet: OutcomesElement?
    var evaluatedSet: Bool?
    var indexSet: Int?
    
    func set(element: OutcomesElement, evaluated: Bool, atIndex index: Int) -> Bool {
        elementSet = element
        evaluatedSet = evaluated
        indexSet = index
        
        return true
    }
    
}
