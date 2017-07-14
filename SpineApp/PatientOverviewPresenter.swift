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
    
    init(delegate: PatientOverviewPresenterDelegate) {
        self.delegate = delegate
    }
    
    func attach(view: PatientOverviewViewController) {
        self.view = view
    }
    
    //Patient Overview Presenter functions
    
    func someAction() {
        print("This")
        delegate?.sceneComplete(self)
    }
    
}
