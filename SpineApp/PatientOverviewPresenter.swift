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
}

class PatientOverviewPresenter {
    
    weak var delegate: PatientOverviewPresenterDelegate?
    weak var view: PatientOverviewViewController?
    let nomogramManager: NomogramManager
    
    init(delegate: PatientOverviewPresenterDelegate, nomogramManager: NomogramManager) {
        self.delegate = delegate
        self.nomogramManager = nomogramManager
    }
    
    func attach(view: PatientOverviewViewController) {
        self.view = view
    }
    
    //Patient Overview Presenter functions
    
    func loadData() {
        var patientOverviewElements = [PatientOverviewElement]()
        
        for (index, nomogram) in nomogramManager.nomograms.enumerated() {
            let hasDetails = (nomogram.description != nil)
            let evaluated = nomogramManager.nomogramEvaulated[index]
            let failurePct = nomogramManager.nomogramFailurePct[index]
            let element = PatientOverviewElement(outcome: nomogram.outcome, hasDetails: hasDetails, evaluated: evaluated, failurePct: failurePct)
            patientOverviewElements.append(element)
        }
        
        view?.set(elements: patientOverviewElements)
    }
    
    func someAction() {
        delegate?.sceneComplete(self)
    }
    
}
