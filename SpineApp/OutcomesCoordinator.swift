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
    
    init(delegate: OutcomesCoordinatorDelegate, navigationController: UINavigationController) {
        self.delegate = delegate
        self.navigationController = navigationController
    }
    
    func start() {
        //create first view controller other assembly
        let presenter = PatientOverviewPresenter(delegate: self)
        let vc = PatientOverviewViewController(nibName: "PatientOverviewViewController", presenter: presenter)
        navigationController.setViewControllers([vc], animated: false)
    }
    
}

extension OutcomesCoordinator: PatientOverviewPresenterDelegate {
    func sceneComplete(_ patientOverviewPresenter: PatientOverviewPresenter) {
        print("Patient Overview Complete")
    }
}
