//
//  MockNomogramView.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/31/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
@testable import SpineApp

class MockNomogramView: NomogramViewProtocol {

    var failurePct: Double = 0
    var outcome: String = ""
    
    var elements = [NomogramElement]()
    
    var setElements_CallCount = 0
    
    func set(elements: [NomogramElement]) {
        setElements_CallCount += 1
        self.elements = elements
    }

    
    var setElement_CallCount = 0
    
    var element: NomogramElement?
    var index: Int?
    
    func set(element: NomogramElement, atIndex index: Int) {
        setElement_CallCount += 1
        self.element = element
        self.index = index
    }
    
}
