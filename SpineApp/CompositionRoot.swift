//
//  CompositionRoot.swift
//  SpineApp
//
//  Created by Peter Cerhan on 9/12/17.
//  Copyright © 2017 Peter Cerhan. All rights reserved.
//

import Foundation
import UIKit

protocol CompositionRootProtocol {
    func assembleWindow() -> UIWindow
    func assembleMainCoordinator() -> MainContainerCoordinator
    func assembleOpenScene(mainContainerCoordinator: MainContainerCoordinator) -> OpenSceneViewController
    func assembleOutcomesModule(mainContainerCoordinator: MainContainerCoordinator) -> OutcomesCoordinator
    func assembleDisclaimerScene(mainContainerCoordinator: MainContainerCoordinator, userProfileStateController: UserProfileStateController) -> DisclaimerViewController
}

class CompositionRoot: CompositionRootProtocol {
    
    func assembleWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    func assembleMainCoordinator() -> MainContainerCoordinator {
        return MainContainerCoordinator(containerViewController: MainContainerViewController(),
                                        userProfileStateController: UserProfileStateController(userDefaults: UserDefaults.standard),
                                        compositionRoot: self)
    }
    
    func assembleOpenScene(mainContainerCoordinator: MainContainerCoordinator) -> OpenSceneViewController {
        let presenter = OpenScenePresenter(delegate: mainContainerCoordinator)
        return OpenSceneViewController(nibName: "OpenSceneViewController",
                                       presenter: presenter)
    }
    
    func assembleDisclaimerScene(mainContainerCoordinator: MainContainerCoordinator, userProfileStateController: UserProfileStateController) -> DisclaimerViewController {
        let presenter = DisclaimerPresenter(delegate: mainContainerCoordinator, userProfileStateController: userProfileStateController)
        return DisclaimerViewController(nibName: "DisclaimerViewController", presenter: presenter)
    }
    
    func assembleOutcomesModule(mainContainerCoordinator: MainContainerCoordinator) -> OutcomesCoordinator {
        let nomogramService = NomogramService()
        let outcomesStateController = OutcomesStateController(nomogramService: nomogramService)
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        
        return OutcomesCoordinator(delegate: mainContainerCoordinator,
                                   navigationController: navigationController,
                                   outcomesStateController: outcomesStateController)
    }
}


