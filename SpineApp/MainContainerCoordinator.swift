//
//  MainContainerCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class MainContainerCoordinator {
    
    //Child objects
    
    let mainContainerViewController: MainContainerViewController
    var childCoordinators = [Any]()
    
    init(containerViewController: MainContainerViewController) {
        mainContainerViewController = containerViewController
    }
    
    func start() {
        let presenter = OpenScenePresenter(delegate: self)
        let vc = OpenSceneViewController(nibName: "OpenSceneViewController", presenter: presenter)
        
        mainContainerViewController.show(viewController: vc, animation: .none)
    }
    
}

extension MainContainerCoordinator: OpenScenePresenterDelegate {

    func sceneComplete(_ openScenePresenter: OpenScenePresenter) {
        let userProfileStateController = UserProfileStateController(userDefaults: UserDefaults.standard)
        if userProfileStateController.disclaimerAgreed() {
            //TODO: repeated code (use assembler class?)
            let nomogramService = NomogramService()
            let outcomesStateController = OutcomesStateController(nomogramService: nomogramService)
            
            let navigationController = UINavigationController()
            navigationController.navigationBar.isTranslucent = false
            
            let coordinator = OutcomesCoordinator(delegate: self, navigationController: navigationController, outcomesStateController: outcomesStateController)
            coordinator.start()
            childCoordinators.append(coordinator)
            
            mainContainerViewController.show(viewController: navigationController, animation: .fadeIn)
            
        } else {
            let presenter = DisclaimerPresenter(delegate: self, userProfileStateController: userProfileStateController)
            let vc = DisclaimerViewController(nibName: "DisclaimerViewController", presenter: presenter)
            
            mainContainerViewController.show(viewController: vc, animation: .fadeIn)
        }
    }
    
}

extension MainContainerCoordinator: DisclaimerPresenterDelegate {
    func sceneComplete(_ disclaimerPresenter: DisclaimerPresenter) {
        let nomogramService = NomogramService()
        let outcomesStateController = OutcomesStateController(nomogramService: nomogramService)
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        
        let coordinator = OutcomesCoordinator(delegate: self, navigationController: navigationController, outcomesStateController: outcomesStateController)
        coordinator.start()
        childCoordinators.append(coordinator)
        
        mainContainerViewController.show(viewController: navigationController, animation: .slideFromRight)
    }
}

extension MainContainerCoordinator: OutcomesCoordinatorDelegate {
    func outcomesComplete(_ outcomesCoordinator: OutcomesCoordinator) {
    }
}
