//
//  OutcomesPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol OutcomesPresenterDelegate: class {
    func sceneComplete(_ outcomesPresenter: OutcomesPresenter)
    func nomogramSelected(_ outcomesPresenter: OutcomesPresenter, atIndex index: Int)
}

protocol OutcomesPresenterProtocol: class {
    func attach(view: OutcomesViewProtocol)
    func loadDataToView()
    func resetAllData()
    func nomogramSelected(atIndex index: Int)
}

class OutcomesPresenter: OutcomesPresenterProtocol {
    
    //MARK: - Dependencies
    
    weak var delegate: OutcomesPresenterDelegate?
    weak var view: OutcomesViewProtocol?
    let outcomesStateController: OutcomesStateControllerProtocol
    
    //MARK: - Initialization
    
    init(delegate: OutcomesPresenterDelegate, outcomesStateController: OutcomesStateControllerProtocol) {
        self.delegate = delegate
        self.outcomesStateController = outcomesStateController
    }
    
    //MARK: - Interface for view (OutcomesPresenterProtocol)
    
    func attach(view: OutcomesViewProtocol) {
        self.view = view
    }
    
    func loadDataToView() {
        view?.set(elements: elements(fromNomograms:  outcomesStateController.nomograms), evaluated: outcomesStateController.nomogramEvaluated)
    }
    
    func resetAllData() {
        outcomesStateController.resetAll()
        view?.set(elements: elements(fromNomograms:  outcomesStateController.nomograms), evaluated: outcomesStateController.nomogramEvaluated)
    }
    
    func nomogramSelected(atIndex index: Int) {
        outcomesStateController.setNomogramEvaluated(atIndex: index)
        delegate?.nomogramSelected(self, atIndex: index)
    }
    
    //MARK: - Application logic
    
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
