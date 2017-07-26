//
//  NomogramPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/24/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol NomogramPresenterDelegate: NSObjectProtocol {
    func nomogramPresenterSceneComplete(_ presenter: NomogramPresenter)
}

class NomogramPresenter {
    
    weak var delegate: NomogramPresenterDelegate?
    weak var view: NomogramViewController?
    let nomogramManager: NomogramManager
    let nomogramIndex: Int
    var score: Double {
        didSet {
            view?.score = score
        }
    }
    
    init(delegate: NomogramPresenterDelegate, nomogramManager: NomogramManager, nomogramIndex: Int) {
        self.delegate = delegate
        self.nomogramManager = nomogramManager
        self.nomogramIndex = nomogramIndex
        score = nomogramManager.nomograms[nomogramIndex].score
    }
    
    func attach(view: NomogramViewController) {
        self.view = view
    }
    
    //Interface for View
    func loadData() {
        var nomogramElements = [NomogramViewControllerElement]()
        
        for predictor in nomogramManager.nomograms[nomogramIndex].predictors {
            let element = nomogramVCElement(forPredictor: predictor)
            nomogramElements.append(element)
        }
        
        score = nomogramManager.nomograms[nomogramIndex].score
        view?.set(elements: nomogramElements)
    }
    
    private func nomogramVCElement(forPredictor predictor: Predictor) -> NomogramViewControllerElement {
        let element = NomogramViewControllerElement(name: predictor.name, description: predictor.description, points: predictor.points, present: predictor.present)
        return element
    }
    
    func updatePresent(atIndex index: Int) {
        let predictor = nomogramManager.updatePredictor(atIndex: index, inNomogramAtIndex: nomogramIndex)
        
        let element = nomogramVCElement(forPredictor: predictor)
        
        score = nomogramManager.nomograms[nomogramIndex].score
        view?.set(element: element, atIndex:index)
    }
    
}

