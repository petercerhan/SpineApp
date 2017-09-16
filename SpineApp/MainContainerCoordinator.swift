//
//  MainContainerCoordinator.swift
//  SpineApp
//
//  Created by Peter Cerhan on 7/13/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import UIKit

class MainContainerCoordinator {
    
    //MARK: - Dependencies
    
    let mainContainerViewController: ContainerViewController
    let userProfileStateController: UserProfileStateController
    let compositionRoot: CompositionRootProtocol
    
    var childCoordinators = [Any]()
    
    init(containerViewController: ContainerViewController, userProfileStateController: UserProfileStateController, compositionRoot: CompositionRootProtocol) {
        mainContainerViewController = containerViewController
        self.userProfileStateController = userProfileStateController
        self.compositionRoot = compositionRoot
    }
    
    func start() {
        let vc = compositionRoot.composeOpenScene(mainContainerCoordinator: self)
        mainContainerViewController.show(viewController: vc, animation: .none)
    }
    
}

extension MainContainerCoordinator: OpenScenePresenterDelegate {

    func sceneComplete(_ openScenePresenter: OpenScenePresenter) {
        
        if userProfileStateController.disclaimerAgreed() {
            let coordinator = compositionRoot.composeOutcomesModule(mainContainerCoordinator: self)
            coordinator.start()
            childCoordinators.append(coordinator)
            
            mainContainerViewController.show(viewController: coordinator.navigationController, animation: .fadeIn)
            
        } else {
            let vc = compositionRoot.composeDisclaimerScene(mainContainerCoordinator: self, userProfileStateController: userProfileStateController)
            mainContainerViewController.show(viewController: vc, animation: .fadeIn)
        }
    }
    
}

extension MainContainerCoordinator: DisclaimerPresenterDelegate {
    
    func sceneComplete(_ disclaimerPresenter: DisclaimerPresenter) {
        let coordinator = compositionRoot.composeOutcomesModule(mainContainerCoordinator: self)
        coordinator.start()
        childCoordinators.append(coordinator)
        
        mainContainerViewController.show(viewController: coordinator.navigationController, animation: .slideFromRight)
    }
}

extension MainContainerCoordinator: OutcomesCoordinatorDelegate {
    func outcomesComplete(_ outcomesCoordinator: OutcomesCoordinator) {
    }
}
