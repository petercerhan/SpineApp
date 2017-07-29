//
//  OutcomesCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

protocol OutcomesCoordinatorDelegate: NSObjectProtocol {
    func outcomesComplete(_ outcomesCoordinator: OutcomesCoordinator)
}

class OutcomesCoordinator: NSObject {
    
    weak var delegate: OutcomesCoordinatorDelegate?
    let navigationController: UINavigationController
    let nomogramManager: NomogramManager
    
    init(delegate: OutcomesCoordinatorDelegate, navigationController: UINavigationController, nomogramManager: NomogramManager) {
        self.delegate = delegate
        self.navigationController = navigationController
        self.nomogramManager = nomogramManager
    }
    
    func start() {
        //create first view controller other assembly
        let presenter = PatientOverviewPresenter(delegate: self, nomogramManager: nomogramManager)
        let vc = PatientOverviewViewController(nibName: "PatientOverviewViewController", presenter: presenter)
        navigationController.setViewControllers([vc], animated: false)
    }
    
}

extension OutcomesCoordinator: PatientOverviewPresenterDelegate {
    func sceneComplete(_ patientOverviewPresenter: PatientOverviewPresenter) {
        delegate?.outcomesComplete(self)
    }
    
    func nomogramSelected(_ patientOverviewPresenter: PatientOverviewPresenter, atIndex index: Int) {
        let presenter = NomogramPresenter(delegate: self, nomogramManager: nomogramManager, nomogramIndex: index)
        let vc = NomogramViewController(nibName: "NomogramViewController", presenter: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}


extension OutcomesCoordinator: NomogramPresenterDelegate {
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        navigationController.popViewController(animated: true)
    }
    
}
