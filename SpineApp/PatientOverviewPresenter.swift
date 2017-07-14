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
        let outcomes = nomogramManager.outcomes()
        view?.set(outcomes: outcomes)
        
    }
    
    func someAction() {
        delegate?.sceneComplete(self)
    }
    
}
