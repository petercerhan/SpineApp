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
    
    init(delegate: NomogramPresenterDelegate, nomogramManager: NomogramManager, nomogramIndex: Int) {
        self.delegate = delegate
        self.nomogramManager = nomogramManager
        self.nomogramIndex = nomogramIndex
    }
    
    func attach(view: NomogramViewController) {
        self.view = view
    }
    
    //Interface for View
    func loadData() {
        var nomogramElements = [NomogramViewControllerElement]()
        
        for predictor in nomogramManager.nomograms[nomogramIndex].predictors {
//            let element = NomogramViewControllerElement(name: predictor.name, description: predictor.description, points: predictor.points, present: predictor.present)
            let element = nomogramVCElement(forPredictor: predictor)
            nomogramElements.append(element)
        }
        
        view?.set(elements: nomogramElements)
    }
    
    private func nomogramVCElement(forPredictor predictor: Predictor) -> NomogramViewControllerElement {
        let element = NomogramViewControllerElement(name: predictor.name, description: predictor.description, points: predictor.points, present: predictor.present)
        return element
    }
    
    func updatePresent(atIndex index: Int) {
        var predictor = nomogramManager.nomograms[nomogramIndex].predictors[index]
        predictor.present = !predictor.present
        nomogramManager.nomograms[nomogramIndex].predictors[index] = predictor
        
        let element = nomogramVCElement(forPredictor: predictor)
        view?.set(element: element, atIndex:index)
    }
    
}

