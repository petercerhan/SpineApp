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
    
    func set(elements: [NomogramElement]) {
        self.elements = elements
    }
    
    var element: NomogramElement?
    var index = 0
    
    func set(element: NomogramElement, atIndex index: Int) {
        self.element = element
        self.index = index
    }
    
}
