//
//  OutcomesPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol OutcomesPresenterDelegate: NSObjectProtocol {
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter)
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int)
}

class OutcomesPresenter {
    
    //MARK: - Dependencies
    
    weak var delegate: OutcomesPresenterDelegate?
    weak var view: OutcomesViewController?
    let outcomesStateController: OutcomesStateController
    
    //MARK: - Initialization
    
    init(delegate: OutcomesPresenterDelegate, outcomesStateController: OutcomesStateController) {
        self.delegate = delegate
        self.outcomesStateController = outcomesStateController
    }
    
    //MARK: - Interface for view
    
    func attach(view: OutcomesViewController) {
        self.view = view
    }
    
    func loadData() {
        view?.set(elements: elements(fromNomograms:  outcomesStateController.nomograms), evaluated: outcomesStateController.nomogramEvaluated)
    }
    
    func resetAll() {
        outcomesStateController.resetAll()
        view?.set(elements: elements(fromNomograms:  outcomesStateController.nomograms), evaluated: outcomesStateController.nomogramEvaluated)
    }
    
    func nomogramSelected(atIndex index: Int) {
        outcomesStateController.setNomogramEvaluated(atIndex: index)
        delegate?.nomogramSelected(self, atIndex: index)
    }
    
    //MARK: - Application logic
    
    typealias OutcomesElement = OutcomesViewController.OutcomesElement
    
    private func elements(fromNomograms nomograms: [Nomogram]) -> [OutcomesElement] {
        var outcomesElements = [OutcomesElement]()
        
        for (index, nomogram) in nomograms.enumerated() {
            let description = nomogram.description
            let evaluated = outcomesStateController.nomogramEvaluated[index]
            let failurePct = nomogram.failurePct
            let element = OutcomesElement(outcome: nomogram.outcome, description: description, evaluated: evaluated, failurePct: failurePct)
            outcomesElements.append(element)
        }
        
        return outcomesElements
    }
    
}
