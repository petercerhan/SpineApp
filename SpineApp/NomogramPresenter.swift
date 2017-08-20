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
    let outcomesStateController: OutcomesStateController
    
    //MARK: - State
    
    let nomogramIndex: Int
    var score: Double
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
    
    init(delegate: NomogramPresenterDelegate, outcomesStateController: OutcomesStateController, nomogramIndex: Int) {
        self.delegate = delegate
        self.outcomesStateController = outcomesStateController
        self.nomogramIndex = nomogramIndex
        score = outcomesStateController.nomograms[nomogramIndex].score
        failurePct = outcomesStateController.nomograms[nomogramIndex].failurePct
    }
    
    //MARK: - Interface for View
    
    func attach(view: NomogramViewController) {
        self.view = view
    }
    
    func loadData() {
        score = outcomesStateController.nomograms[nomogramIndex].score
        failurePct = outcomesStateController.nomograms[nomogramIndex].failurePct
        outcome = outcomesStateController.nomograms[nomogramIndex].outcome
        view?.set(elements: elements(forNomogram: outcomesStateController.nomograms[nomogramIndex]))
    }
    
    func updatePresent(atIndex index: Int) {
        let predictor = outcomesStateController.updatePredictor(atIndex: index, inNomogramAtIndex: nomogramIndex)
        
        let element = nomogramVCElement(forPredictor: predictor)
        
        score = outcomesStateController.nomograms[nomogramIndex].score
        failurePct = outcomesStateController.nomograms[nomogramIndex].failurePct
        view?.set(element: element, atIndex: index)
    }
    
    func resetNomogram() {
        outcomesStateController.resetNomogram(atIndex: nomogramIndex)
        
        score = outcomesStateController.nomograms[nomogramIndex].score
        failurePct = outcomesStateController.nomograms[nomogramIndex].failurePct
        view?.set(elements: elements(forNomogram: outcomesStateController.nomograms[nomogramIndex]))
    }
    
    func sceneComplete() {
        delegate?.sceneComplete(self)
    }
    
    //MARK: - Application Logic
    
    private func elements(forNomogram nomogram: Nomogram) -> [NomogramViewControllerElement] {
        var nomogramVCElements = [NomogramViewControllerElement]()
        
        for predictor in outcomesStateController.nomograms[nomogramIndex].predictors {
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





