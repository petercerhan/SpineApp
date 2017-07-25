//
//  MainContainerCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class MainContainerCoordinator: NSObject {
    
    let mainContainerViewController: MainContainerViewController
    var childCoordinators = [NSObject]()
    
    init(containerViewController: MainContainerViewController) {
        mainContainerViewController = containerViewController
    }
    
    func start() {
        let presenter = OpenScenePresenter(delegate: self)
        let vc = OpenSceneViewController(nibName: "OpenSceneViewController", presenter: presenter)
        
        mainContainerViewController.show(viewController: vc, animated: false)
    }
    
}

extension MainContainerCoordinator: OpenScenePresenterDelegate {
    func sceneComplete(_ openScenePresenter: OpenScenePresenter) {
        let presenter = DisclaimerPresenter(delegate: self)
        let vc = DisclaimerViewController(nibName: "DisclaimerViewController", presenter: presenter)
        
        mainContainerViewController.show(viewController: vc, animated: false)
    }
}

extension MainContainerCoordinator: DisclaimerPresenterDelegate {
    func sceneComplete(_ disclaimerPresenter: DisclaimerPresenter) {
        let nomogramService = NomogramService()
        let nomogramManager = NomogramManager(nomogramService: nomogramService)
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        let coordinator = OutcomesCoordinator(delegate: self, navigationController: navigationController, nomogramManager: nomogramManager)
        coordinator.start()
        childCoordinators.append(coordinator)
        
        mainContainerViewController.show(viewController: navigationController, animated: true)
    }
}

extension MainContainerCoordinator: OutcomesCoordinatorDelegate {
    func outcomesComplete(_ outcomesCoordinator: OutcomesCoordinator) {
        let presenter = DisclaimerPresenter(delegate: self)
        let vc = DisclaimerViewController(nibName: "DisclaimerViewController", presenter: presenter)
        
        mainContainerViewController.show(viewController: vc, animated: true)
        childCoordinators = [NSObject]()
        //print("Outcomes complete")
    }
}
