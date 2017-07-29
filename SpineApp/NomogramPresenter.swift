//
//  NomogramPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/24/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol NomogramPresenterDelegate: NSObjectProtocol {
    func sceneComplete(_ presenter: NomogramPresenter)
}

class NomogramPresenter {
    
    //MARK: - Dependencies
    
    weak var delegate: NomogramPresenterDelegate?
    weak var view: NomogramViewController?
    let nomogramManager: NomogramManager
    
    //MARK: - State
    
    let nomogramIndex: Int
    var score: Double {
        didSet {
            view?.score = score
        }
    }
    var failurePct: Double {
        didSet {
            view?.failurePct = failurePct
        }
    }
    var outcome = "" {
        didSet {
            view?.outcome = outcome
        }
    }
    
    //MARK: - Initialization
    
    init(delegate: NomogramPresenterDelegate, nomogramManager: NomogramManager, nomogramIndex: Int) {
        self.delegate = delegate
        self.nomogramManager = nomogramManager
        self.nomogramIndex = nomogramIndex
        score = nomogramManager.nomograms[nomogramIndex].score
        failurePct = nomogramManager.nomogramFailurePct[nomogramIndex]
    }
    
    //MARK: - Interface for View
    
    func attach(view: NomogramViewController) {
        self.view = view
    }
    
    func loadData() {
        score = nomogramManager.nomograms[nomogramIndex].score
        failurePct = nomogramManager.nomogramFailurePct[nomogramIndex]
        outcome = nomogramManager.nomograms[nomogramIndex].outcome
        view?.set(elements: elements(forNomogram: nomogramManager.nomograms[nomogramIndex]))
    }
    
    func updatePresent(atIndex index: Int) {
        let predictor = nomogramManager.updatePredictor(atIndex: index, inNomogramAtIndex: nomogramIndex)
        
        let element = nomogramVCElement(forPredictor: predictor)
        
        score = nomogramManager.nomograms[nomogramIndex].score
        failurePct = nomogramManager.nomogramFailurePct[nomogramIndex]
        view?.set(element: element, atIndex:index)
    }
    
    func resetNomogram() {
        nomogramManager.resetNomogram(atIndex: nomogramIndex)
        
        score = nomogramManager.nomograms[nomogramIndex].score
        failurePct = nomogramManager.nomogramFailurePct[nomogramIndex]
        view?.set(elements: elements(forNomogram: nomogramManager.nomograms[nomogramIndex]))
    }
    
    func sceneComplete() {
        delegate?.sceneComplete(self)
    }
    
    //MARK: - Application Logic
    
    private func elements(forNomogram nomogram: Nomogram) -> [NomogramViewControllerElement] {
        var nomogramVCElements = [NomogramViewControllerElement]()
        
        for predictor in nomogramManager.nomograms[nomogramIndex].predictors {
            let element = nomogramVCElement(forPredictor: predictor)
            nomogramVCElements.append(element)
        }
        
        return nomogramVCElements
    }
    
    private func nomogramVCElement(forPredictor predictor: Predictor) -> NomogramViewControllerElement {
        let element = NomogramViewControllerElement(name: predictor.name, description: predictor.description, points: predictor.points, present: predictor.present)
        return element
    }
}





