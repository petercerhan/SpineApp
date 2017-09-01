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
    var nomogramSelectedIndex: Int?
    var nomogramSceneComplete = false
    
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter) {
        sceneCompleteCalled = true
    }
    
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int) {
        nomogramSelectedIndex = index
    }
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        nomogramSceneComplete = true
    }
    
}

