//
//  PatientOverviewPresenter.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation

protocol PatientOverviewPresenterDelegate: NSObjectProtocol {
    func sceneComplete(_ patientOverviewPresenter: PatientOverviewPresenter)
    func nomogramSelected(_ patientOverviewPresenter: PatientOverviewPresenter, atIndex index: Int)
}

class PatientOverviewPresenter {
    
    //MARK: - Dependencies
    
    weak var delegate: PatientOverviewPresenterDelegate?
    weak var view: PatientOverviewViewController?
    let nomogramManager: NomogramManager
    
    //MARK: - Initialization
    
    init(delegate: PatientOverviewPresenterDelegate, nomogramManager: NomogramManager) {
        self.delegate = delegate
        self.nomogramManager = nomogramManager
    }
    
    //MARK: - Interface for view
    
    func attach(view: PatientOverviewViewController) {
        self.view = view
    }
    
    func loadData() {
        view?.set(elements: elements(fromNomograms:  nomogramManager.nomograms))
    }
    
    func resetAll() {
        nomogramManager.resetAll()
        view?.set(elements: elements(fromNomograms:  nomogramManager.nomograms))
    }
    
    func nomogramSelected(atIndex index: Int) {
        delegate?.nomogramSelected(self, atIndex: index)
    }
    
    //MARK: - Application logic
    
    private func elements(fromNomograms nomograms: [Nomogram]) -> [PatientOverviewElement] {
        var patientOverviewElements = [PatientOverviewElement]()
        
        for (index, nomogram) in nomograms.enumerated() {
            let description = nomogram.description
            let evaluated = nomogramManager.nomogramEvaulated[index]
            let failurePct = nomogram.failurePct
            let element = PatientOverviewElement(outcome: nomogram.outcome, description: description, evaluated: evaluated, failurePct: failurePct)
            patientOverviewElements.append(element)
        }
        
        return patientOverviewElements
    }
    
}
