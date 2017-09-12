//
//  MockOutcomesCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 8/31/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
@testable import SpineApp

class MockOutcomesCoordinator: OutcomesPresenterDelegate, NomogramPresenterDelegate {
    
    var sceneCompleteCalled = false
    var nomogramSceneComplete = false
    
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter) {
        sceneCompleteCalled = true
    }
    
    
    var nomogramSelectedCallCount = 0
    var nomogramSelected_atIndex: Int?
    
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int) {
        nomogramSelectedCallCount += 1
        nomogramSelected_atIndex = index
    }
    
    var sceneCompleteCallCount = 0
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        sceneCompleteCallCount += 1
    }
    
}

