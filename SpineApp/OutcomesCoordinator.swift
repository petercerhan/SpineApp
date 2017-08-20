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
    let outcomesStateController: OutcomesStateController
    
    init(delegate: OutcomesCoordinatorDelegate, navigationController: UINavigationController, outcomesStateController: OutcomesStateController) {
        self.delegate = delegate
        self.navigationController = navigationController
        self.outcomesStateController = outcomesStateController
    }
    
    func start() {
        //create first view controller other assembly
        let presenter = PatientOverviewPresenter(delegate: self, outcomesStateController: outcomesStateController)
        let vc = PatientOverviewViewController(nibName: "PatientOverviewViewController", presenter: presenter)
        navigationController.setViewControllers([vc], animated: false)
    }
    
}

extension OutcomesCoordinator: PatientOverviewPresenterDelegate {
    func sceneComplete(_ patientOverviewPresenter: PatientOverviewPresenter) {
        delegate?.outcomesComplete(self)
    }
    
    func nomogramSelected(_ patientOverviewPresenter: PatientOverviewPresenter, atIndex index: Int) {
        let presenter = NomogramPresenter(delegate: self, outcomesStateController: outcomesStateController, nomogramIndex: index)
        let vc = NomogramViewController(nibName: "NomogramViewController", presenter: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}


extension OutcomesCoordinator: NomogramPresenterDelegate {
    
    func sceneComplete(_ presenter: NomogramPresenter) {
        navigationController.popViewController(animated: true)
    }
    
}
